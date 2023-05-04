//
//  CustomTabBar.swift
//  OnTime
//
//  Created by aplle on 5/5/23.
//

import SwiftUI

enum Tab:String,CaseIterable{
    case house
    case heart
    case person
}

struct CustomTabBar: View {
    @Binding var selectedTab:Tab
    private var fillImage:String{
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack{
            HStack{
                ForEach(Tab.allCases,id:\.rawValue){tab in
                    Spacer()
                    ZStack{
                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                            .foregroundColor(selectedTab == tab ? Color.backgroundColor : .gray)
                            .font(.system(size: 20))
                            .offset(y: selectedTab == tab ? -7 : 0)
                            .shadow(color: Color.green,radius:selectedTab == tab ? 15 : 0)
                            .onTapGesture{
                                withAnimation(.easeIn(duration: 0.1)){
                                    selectedTab = tab
                                }
                            }
                        if selectedTab == tab{
                                                   Rectangle()
                                                       .fill(Color.green)
                                                       .frame(width: 20,height: 1.5)
                                                       .offset(y:15)
                                                      
                                                       
                                                       
                                               }
                       
                    }
                    Spacer()
                    
                }
                
            }
            .frame(width: nil,height: 80)
            .background(.thinMaterial)
            .cornerRadius(30)
            .padding(.horizontal,5)
            .ignoresSafeArea()
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(Tab.house))
    }
}
