//
//  AppState.swift
//  Praxi
//
//  Created by Augustus Murphy on 12/7/20.
//

// Thank you to Majid at swiftwithmajid.com for this great article!
// https://swiftwithmajid.com/2019/09/18/redux-like-state-container-in-swiftui/

import Foundation

struct AppState {
    /* In order to be more performant, the exercises themselves are stored in a dictionary
     with their IDs as keys, and the ordering of them is stored seperately as a simple array
     of those IDs. */
    var exercises: [UUID: Exercise] = [Exercise.default.id: Exercise.default]
    var allExercises: [UUID] = [Exercise.default.id]
}

enum AppAction {
    case addNew(exercise: Exercise, with: UUID)
    case replace(exerciseWith: UUID, withNew: Exercise)
}

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case let .addNew(exercise: exercise, with: id):
        state.exercises[id] = exercise
        state.allExercises.append(id)
    case let .replace(exerciseWith: id, withNew: exercise):
        state.exercises[id] = exercise
    }
}

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>
    
    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        reducer(&state, action)
    }
}

typealias AppStore = Store<AppState, AppAction>
