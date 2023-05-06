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
                            .offset(y: selectedTab == tab ? -10 : 0)
                            .shadow(color: Color.green,radius:selectedTab == tab ? 15 : 0)
                            .onTapGesture{
                                withAnimation(.easeIn(duration: 0.2)){
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
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .padding(.horizontal,10)
            .shadow(color:.green,radius: 5)
           
        }
        .ignoresSafeArea()
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(Tab.house))
    }
}

struct CustomSideBar: View {
    let startX:CGFloat
    @Binding var selectedTab:Tab
    @Binding var currentDragOffset:CGFloat
    @Binding var endX:CGFloat
    private var fillImage:String{
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        ZStack{
            VStack{
                
                VStack{
                    ForEach(Tab.allCases,id:\.rawValue){tab in
                        Spacer()
                        ZStack{
                            Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                                .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                                .foregroundColor(selectedTab == tab ? Color.backgroundColor : .gray)
                                .font(.system(size: 20))
                                .offset(y: selectedTab == tab ? -10 : 0)
                                .shadow(color: Color.green,radius:selectedTab == tab ? 15 : 0)
                                .onTapGesture{
                                    withAnimation(.easeIn(duration: 0.2)){
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
                .frame(width: 80,height: 300)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.vertical,10)
                .shadow(color:.green,radius: 5)
                
            }
            RoundedRectangle(cornerRadius: 5)
                .fill(.ultraThinMaterial)
                .frame(width:25,height:60)
                .overlay{
                    VStack(alignment: .center){
                        Image(systemName: "line.3.horizontal")
                            .padding(3)
                    }
                }
                .offset(x:50)
                
            
        }
        .padding(.leading,5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .offset(x:startX + currentDragOffset + endX)
        .gesture(
        DragGesture()
            .onChanged{value in
                withAnimation(.spring()){
                    currentDragOffset = value.translation.width
                }
            }
            .onEnded{value in
                withAnimation(.spring()){
                    if currentDragOffset > 10{
                        endX = -startX
                        currentDragOffset = 0
                    }else if endX != 0 && currentDragOffset < 10{
                        endX = 0
                        currentDragOffset = 0
                    }else{
                        currentDragOffset = 0
                    }
                }
            }
        )
    }
}

