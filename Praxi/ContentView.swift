//
//  ContentView.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        NavigationView {
            List {
                NavigationLink (
                    destination: ExerciseList()
                ) {
                    Text("Exercises")
                }
            }
            .navigationTitle("Home")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}
