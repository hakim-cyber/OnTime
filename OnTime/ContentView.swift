//
//  ContentView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI

struct ContentView: View {
   @StateObject var projects = ProjectsArray()
    var body: some View {
        NavigationView{
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                TabView{
                    Text("Main")
                        .tabItem{
                            Image(systemName: "house.fill")
                            Text("Main")
                        }
                    
                    Text("Favourites")
                        .tabItem{
                            Image(systemName: "heart.fill")
                            Text("Favorites")
                        }
                    Text("Profile")
                        .tabItem{
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                    
                }
                .environmentObject(projects)
                
                .background(Color.blue)
                .accentColor(.green)
                .transition(.slide)
                
            }
            .toolbar{
                Button("Add"){
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
