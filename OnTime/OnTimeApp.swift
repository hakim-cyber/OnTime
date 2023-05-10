//
//  OnTimeApp.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI
import Firebase

@main
struct OnTimeApp: App {
    @StateObject var projects = ProjectsArray()
    @StateObject var dataManager = DataManager()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
           ContentView()
                .environmentObject(dataManager)
                
                
        }
    }
}
