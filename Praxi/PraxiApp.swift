//
//  PraxiApp.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import SwiftUI

@main
struct PraxiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: AppStore(initialState: AppState.default, reducer: appReducer))
//            ContentView().environmentObject(UserData())
        }
    }
}
