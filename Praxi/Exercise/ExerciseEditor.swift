//
//  ExerciseEditor.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

struct ExerciseEditor: View {
    @Binding var exercise: Exercise
    @State private var showImagePicker = false
    @State private var showVariableEditor = false
    @State private var showAreaEditor = false
    @State private var lowerEditorIsActive = false
    @State private var draftVariable = ExerciseVariable()
    @State private var draftArea = ""
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Name").font(.headline)
                TextField("Name", text: $exercise.name)
            }
            
            // TODO: Add image editing
            VStack(alignment: .leading) {
                HStack {
                    Text("Image").font(.headline)
                    Button(action: {
                        self.showImagePicker.toggle()
                    }) {
                        Image(systemName: "camera")
                            .foregroundColor(.blue)
                    }
                }
                
                if $exercise.image.wrappedValue != nil {
                    $exercise.image.wrappedValue!
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
                    
                    if !showVariableEditor && !lowerEditorIsActive {
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
                        VariableEditor(variable: $draftVariable, isEditing: $lowerEditorIsActive)
                        
                        if !lowerEditorIsActive {
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    self.exercise.variables.insert($draftVariable.wrappedValue, at: 0)
                                    self.draftVariable = ExerciseVariable()
                                    self.showVariableEditor.toggle()
                                }) {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.green)
                                        .imageScale(.large)
                                }
                                
                                Button(action: {
                                    self.draftVariable = ExerciseVariable()
                                    self.showVariableEditor.toggle()
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                }
                            }
                        }
                    }
                }
                
                if self.exercise.variables.count > 0 {
                    VStack(alignment: .leading) {
                        ForEach(self.exercise.variables, id: \.self) { variable in
                            ExerciseVariableSummary(variable: variable)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Areas").font(.headline)
                    
                    if !showAreaEditor && !lowerEditorIsActive {
                        Button(action: {
                            self.showAreaEditor.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                        }
                    }
                }
                
                if showAreaEditor {
                    AreaEditor(area: $draftArea)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            self.exercise.areas.insert($draftArea.wrappedValue, at: 0)
                            self.draftArea = ""
                            self.showAreaEditor.toggle()
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    
                        Button(action: {
                            self.draftArea = ""
                            self.showAreaEditor.toggle()
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.red)
                                .imageScale(.large)
                        }
                    }
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
        .padding()
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        self.exercise.image = Image(uiImage: inputImage)
    }
}

struct VariableEditor: View {
    @Binding var variable: ExerciseVariable
    @Binding var isEditing: Bool
    @State var showMemberEditor = false
    @State var draftMember = ""
    
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
                    
                    if !showMemberEditor {
                        Button(action: {
                            self.isEditing.toggle()
                            self.showMemberEditor.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                        }
                    }
                }
                
                if showMemberEditor {
                    HStack {
                        TextField("New Member", text: $draftMember)
                        
                        Spacer()
                        Button(action: {
                            self.variable.setMembers.insert($draftMember.wrappedValue, at: 0)
                            self.draftMember = ""
                            self.showMemberEditor.toggle()
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    
                        Button(action: {
                            self.draftMember = ""
                            self.showMemberEditor.toggle()
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.red)
                                .imageScale(.large)
                        }
                    }
                }
                
                VStack {
                    ForEach(variable.setMembers, id: \.self) { member in
                        Text(member)
                    }
                }
            }
        }
        .border(Color.black, width: 1)
    }
}

struct AreaEditor: View {
    @Binding var area: String
    
    var body: some View {
        Text("Name").font(.headline)
        TextField("Name", text: $area)
    }
}
