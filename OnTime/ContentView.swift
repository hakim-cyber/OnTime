//
//  ContentView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI

struct ContentView: View {
   @StateObject var projects = ProjectsArray()
    @State private var selectedTab:Tab = .house
    @State var showTabBar = true
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    TabView(selection: $selectedTab){
                        ForEach(Tab.allCases , id:\.rawValue){tab in
                            
                                if tab == .house{
                                    MainView( showingFull: {showTabBar.toggle()})
                                        .environmentObject(projects)
                                        .tag(tab)
                                        .preferredColorScheme(.dark)
                                    }
                            if tab == .heart{
                                HStack{
                                    Text("Coming Soon")
                                }
                                .tag(tab)
                            }
                            if tab == .person{
                                HStack{
                                    Text("Coming Soon")
                                }
                                .tag(tab)
                            }
                        }
                    }
                }
                
                VStack{
                    Spacer()
                    Spacer()
                    if showTabBar{
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
               
                
            }
            .onAppear{
                showTabBar = true
                projects.loadProjects()
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
