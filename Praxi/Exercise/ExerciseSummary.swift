//
//  ExerciseSummary.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

struct ExerciseSummary: View {
    var exercise: Exercise
    
    var body: some View {
        List {
            if exercise.image != nil {
                exercise.image!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Text(exercise.description)
        
            VStack(alignment: .leading) {
                Text("Variables")
                    .font(.headline)
            
                if exercise.variables.count > 0 {
                    VStack(alignment: .leading) {
                        ForEach(exercise.variables, id: \.self) { variable in
                            ExerciseVariableSummary(variable: variable)
                        }
                    }
                    .padding(.top)
                } else {
                    Text("None")
                }
            }
        
            VStack(alignment: .leading) {
                Text("Areas")
                    .font(.headline)
            
                HStack {
                    ForEach(exercise.areas, id: \.self) { area in
                        Badge(name: area)
                    }
                }
                .padding(.top)
            }
        }
    }
}

struct ExerciseVariableSummary: View {
    var variable: ExerciseVariable
    
    var body: some View {
        if let setVariable = variable as? ExerciseSetVariable {
            VStack(alignment: .leading) {
                HStack {
                    Text(setVariable.name)
                    Badge(name: "set")
                }
                
                HStack {
                    ForEach(setVariable.members, id: \.self) { member in
                        SetMemberBadge(name: member)
                    }
                }
            }
        } else if let rangeVariable = variable as? ExerciseRangeVariable {
            VStack(alignment: .leading) {
                HStack {
                    Text(rangeVariable.name)
                    Badge(name: "range")
                }
            }
        }
//        if variable.setMembers.count > 0 {
//            VStack(alignment: .leading) {
//                HStack {
//                    Text(variable.name)
//                    Badge(name: variable.type)
//                }
//
//                Text(variable.getSetMembersString())
//                    .padding(.leading)
//            }
//        } else {
//            HStack {
//                Text(variable.name)
//                Badge(name: variable.type)
//            }
//        }
    }
}

struct ExerciseSummary_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSummary(exercise: Exercise.default)
    }
}
