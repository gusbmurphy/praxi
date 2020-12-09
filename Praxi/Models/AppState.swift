//
//  AppState.swift
//  Praxi
//
//  Created by Augustus Murphy on 12/7/20.
//

// Thank you to Majid at swiftwithmajid.com for this great article!
// https://swiftwithmajid.com/2019/09/18/redux-like-state-container-in-swiftui

// And also to Point-Free for their great materials that probably inspired Majid:
// https://www.pointfree.co/episodes/ep68-composable-state-management-reducers

import Foundation

struct AppState {
    /* In order to be more performant, the exercises themselves are stored in a dictionary
     with their IDs as keys, and the ordering of them is stored seperately as a simple array
     of those IDs. */
    var exercises: [UUID: Exercise] = [Exercise.default.id: Exercise.default]
    var allExercises: [UUID] = [Exercise.default.id]
}

enum AppAction {
    case addNew(exercise: Exercise)
    case replace(exerciseWith: UUID, withNew: Exercise)
}

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case let .addNew(exercise: exercise):
        state.exercises[exercise.id] = exercise
        state.allExercises.append(exercise.id)
    case let .replace(exerciseWith: id, withNew: exercise):
        state.exercises[id] = exercise
    }
}

typealias AppStore = Store<AppState, AppAction>

extension AppState {
    static let `default` = Self(
        exercises: [Exercise.default.id: Exercise.default],
        allExercises: [Exercise.default.id]
    )
}
