//
//  ExerciseHost.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

struct ExerciseHost: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var userData: UserData
    @State var draftExercise = Exercise.default
    var exerciseIndex: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.draftExercise = self.userData.exercises[exerciseIndex]
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }

                Spacer()

                EditButton()
            }

            if self.mode?.wrappedValue == .inactive {
                ExerciseSummary(exercise: userData.exercises[exerciseIndex])
            } else {
                ExerciseEditor(exercise: $draftExercise)
                    .onAppear {
                        self.draftExercise = self.userData.exercises[exerciseIndex]
                    }
                    .onDisappear {
                        self.userData.exercises[exerciseIndex] = self.draftExercise
                    }
            }
        }
        .padding()
        .navigationTitle(userData.exercises[exerciseIndex].name)
//        .toolbar(content: {
//            ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
//                HStack {
//                    if self.mode?.wrappedValue == .active {
//                        Button("Cancel") {
//                            self.draftExercise = self.userData.exercises[exerciseIndex]
//                            self.mode?.animation().wrappedValue = .inactive
//                        }
//                    }
//
//                    EditButton()
//                }
//            }
//        })
    }
}

struct Badge: View {
    var name: String

    var body: some View {
        Text(name.uppercased())
            .font(.subheadline)
            .foregroundColor(.white)
            .background(Color.gray)
    }
}

struct ExerciseHost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseHost(exerciseIndex: 0).environmentObject(UserData())
        }
    }
}
