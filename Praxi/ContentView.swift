//
//  ContentView.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: AppStore
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink (
                    destination: ExerciseList(store: self.store)
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
        ContentView(store: AppStore(initialState: AppState.default, reducer: appReducer))
    }
}
