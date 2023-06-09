//
//  ContentView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI



struct ContentView: View {
   @StateObject var projects = ProjectsArray()
    @EnvironmentObject var dataManager:DataManager
    @State private var selectedTab:Tab = .house
    @State var showTabBar = true
    @State var showAddView = false
    
    
    @State var startX:CGFloat = UIScreen.main.bounds.width * -0.20
    @State var currentDragOffsetX:CGFloat = 0
    @State var endX:CGFloat = 0
    
    
    
    
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
                                    MainView( showingFull: {showTabBar.toggle()}, showAddView: $showAddView)
                                        .environmentObject(projects)
                                       
                                        .tag(tab)
                                        
                                    }
                            if tab == .heart{
                                FavoritesView( showingFull: {showTabBar.toggle()}, showAddView: $showAddView)
                                   
                                    .environmentObject(projects)
                                    .tag(tab)
                                   
                               
                            }
                            if tab == .person{
                                SettingsView()
                                    .environmentObject(projects)
                                .tag(tab)
                                
                            }
                        }
                    }
                    .transition(.slide)
                }
                
                VStack{
                   Spacer()
                    Spacer()
                    if showTabBar{
                        CustomTabBar(selectedTab: $selectedTab, shwAddView: $showAddView)
                    }
                }
               
                
            }
            .onAppear{
                showTabBar = true
                projects.loadProjects()
            }
            
          
           
        }
        .navigationViewStyle(.stack)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
    }
}
