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
    @State var draftRecord = ExerciseRecord()
    @State var showNewRecordSheet = false
    var exerciseIndex: Int

    var body: some View {
        VStack(alignment: .leading) {
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
        .sheet(isPresented: $showNewRecordSheet, content: {
            NewRecordView(record: $draftRecord, shouldShow: $showNewRecordSheet)
        })
        .navigationTitle(userData.exercises[exerciseIndex].name)
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.draftExercise = self.userData.exercises[exerciseIndex]
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }
            }

            ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
                EditButton()
            }

            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                Button(action: {
                    showNewRecordSheet.toggle()
                }, label: {
                    Image(systemName: "pencil.circle.fill")
                        .imageScale(.large)
                })
            }
        })
    }
}

struct NewRecordView: View {
    @Binding var record: ExerciseRecord
    @Binding var shouldShow: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text(getFormattedDate(record.date))
            }
            .navigationBarTitle(Text("New Record"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                shouldShow.toggle()
            }, label: {
                Text("Done")
            }))
        }
    }

    func getFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = .current

        return formatter.string(from: date)
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

struct SetMemberBadge: View {
    var name: String

    var body: some View {
        Text(name)
            .foregroundColor(.white)
            .background(Color.blue)
    }
}

struct ExerciseHost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseHost(exerciseIndex: 0).environmentObject(UserData())
        }
    }
}
