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
                                    MainView()
                                        .environmentObject(projects)
                                        .tag(tab)
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
                    CustomTabBar(selectedTab: $selectedTab)
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
