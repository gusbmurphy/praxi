//
//  VariableEditor.swift
//  Praxi
//
//  Created by Augustus Murphy on 11/12/20.
//

import SwiftUI

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
            
//            HStack {
//                Text("Type").font(.headline)
//                TextField("Type", text: $variable.type)
//            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Members").font(.headline)
                    
                    if variable is ExerciseSetVariable && !showMemberEditor {
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
                
                if let setVariable = variable as? ExerciseSetVariable {
                    if showMemberEditor {
                        HStack {
                            TextField("New Member", text: $draftMember)
                        
                            Spacer()
                            Button(action: {
                                setVariable.members.insert($draftMember.wrappedValue, at: 0)
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
                }
                
                if let setVariable = variable as? ExerciseSetVariable {
                    VStack {
                        ForEach(setVariable.members, id: \.self) { member in
                            Text(member)
                        }
                    }
                } else {
                    EmptyView()
                }
            }
        }
        .border(Color.black, width: 1)
    }
}

struct VariableEditor_Previews: PreviewProvider {
    static var previews: some View {
        VariableEditor()
    }
}
