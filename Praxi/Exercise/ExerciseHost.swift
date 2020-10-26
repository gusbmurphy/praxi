//
//  ExerciseHost.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

struct ExerciseHost: View {
    @Environment(\.editMode) var mode
    @State var draftExercise = Exercise.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                EditButton()
            }
            
            ExerciseSummary(exercise: draftExercise)
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
        ExerciseHost()
    }
}
