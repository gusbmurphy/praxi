//
//  ExerciseList.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/29/20.
//

import SwiftUI

struct ExerciseList: View {
//    @EnvironmentObject var userData: UserData
    @ObservedObject var store: AppStore
    
    var body: some View {
        List {
            ForEach(0 ..< store.state.allExercises.count) { index in
                NavigationLink(destination: ExerciseHost(store: self.store, exerciseId: store.state.allExercises[index])) {
                    Text(store.state.exercises[store.state.allExercises[index]]!.name)
                }
            }
//            ForEach(0 ..< userData.exercises.count, id: \.self) { index in
//                NavigationLink(destination: ExerciseHost(exerciseIndex: index)) {
//                    Text(userData.exercises[index].name)
//                }
//            }
        }
        .navigationTitle(Text("Exercises"))
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
                Button(action: {
                    var newExercise = Exercise.default
                        
                    func exercisesContains(name: String) -> Bool {
                        store.state.exercises.contains { (key: UUID, value: Exercise) -> Bool in
                            value.name == newExercise.name
                        }
//                        self.userData.exercises.contains { element in
//                            element.name == newExercise.name
//                        }
                    }
                        
                    let originalName = newExercise.name
                    var i = 0
                        
                    while exercisesContains(name: newExercise.name) {
                        i += 1
                        newExercise.name = originalName + " \(i)"
                    }
                        
                    store.send(.addNew(exercise: newExercise))
//                    self.userData.exercises.insert(newExercise, at: 0)
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        })
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList(store: AppStore(initialState: AppState.default, reducer: appReducer))
//        ExerciseList().environmentObject(UserData())
    }
}
