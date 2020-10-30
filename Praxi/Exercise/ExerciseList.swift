//
//  ExerciseList.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/29/20.
//

import SwiftUI

struct ExerciseList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(0 ..< userData.exercises.count, id: \.self) { index in
                NavigationLink(destination: ExerciseHost(exerciseIndex: index)) {
                    Text(userData.exercises[index].name)
                }
            }
        }
        .navigationTitle(Text("Exercises"))
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
                Button(action: {
                    var newExercise = Exercise.default
                        
                    func exercisesContains(name: String) -> Bool {
                        self.userData.exercises.contains { element in
                            element.name == newExercise.name
                        }
                    }
                        
                    let originalName = newExercise.name
                    var i = 0
                        
                    while exercisesContains(name: newExercise.name) {
                        i += 1
                        newExercise.name = originalName + " \(i)"
                    }
                        
                    self.userData.exercises.insert(newExercise, at: 0)
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        })
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList().environmentObject(UserData())
    }
}
