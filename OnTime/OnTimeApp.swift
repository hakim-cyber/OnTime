//
//  OnTimeApp.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI

@main
struct OnTimeApp: App {
    @StateObject var projects = ProjectsArray()
    var body: some Scene {
        WindowGroup {
           ContentView()
                
        }
    }
}
