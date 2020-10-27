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

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.draftExercise = self.userData.exercise
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }

                Spacer()

                EditButton()
            }

            if self.mode?.wrappedValue == .inactive {
                ExerciseSummary(exercise: userData.exercise)
            } else {
                ExerciseEditor(exercise: $draftExercise)
                    .onAppear {
                        self.draftExercise = self.userData.exercise
                    }
                    .onDisappear {
                        self.userData.exercise = self.draftExercise
                    }
            }
        }
        .padding()
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
        ExerciseHost().environmentObject(UserData())
    }
}
