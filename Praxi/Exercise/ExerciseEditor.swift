//
//  ExerciseEditor.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

struct ExerciseEditor: View {
    @Binding var exercise: Exercise
    @State private var showVariableEditor = false
    @State private var showAreaEditor = false
    @State private var draftVariable: ExerciseVariable = ExerciseVariable()
    @State private var draftArea = ""
    
    var body: some View {
        List {
            HStack {
                Text("Name").font(.headline)
                Divider()
                TextField("Name", text: $exercise.name)
            }
            
            // TODO: Add image editing
            VStack(alignment: .leading) {
                HStack {
                    Text("Image").font(.headline)
                    Image(systemName: "camera")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                
                if exercise.imageName != nil {
                    Image(exercise.imageName!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Description").font(.headline)
                TextEditor(text: $exercise.description)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Variables").font(.headline)
                    if !showVariableEditor {
                        Button(action: {
                            self.showVariableEditor.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                        }
                    }
                }
                
                if showVariableEditor {
                    Group {
                        VariableEditor(variable: $draftVariable)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.showVariableEditor.toggle()
                            }) {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                            
                            Button(action: {
                                self.showVariableEditor.toggle()
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                                    .imageScale(.large)
                            }
                        }
                    }
                }
                
                if exercise.variables.count > 0 {
                    VStack(alignment: .leading) {
                        ForEach(exercise.variables, id: \.self) { variable in
                            ExerciseVariableSummary(variable: variable)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Areas").font(.headline)
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
                    
                if exercise.areas.count > 0 {
                    VStack(alignment: .leading) {
                        ForEach(exercise.areas, id: \.self) { area in
                            Badge(name: area)
                        }
                    }
                }
            }
        }
    }
}

struct VariableEditor: View {
    @Binding var variable: ExerciseVariable
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Name").font(.headline)
                TextField("Name", text: $variable.name)
            }
            
            HStack {
                Text("Type").font(.headline)
                TextField("Type", text: $variable.type)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Members").font(.headline)
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
                
                VStack {
                    ForEach(variable.setMembers, id: \.self) { member in
                        Text(member)
                    }
                }
            }
        }
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}

struct ExerciseEditor_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseEditor(exercise: .constant(.default))
//        VariableEditor(variable: .constant(Exercise.default.variables[1]))
    }
}
