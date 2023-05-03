//
//  MainView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var Projects:ProjectsArray
    
    @Namespace var nameSpace
    
    @State  var showFull = false
    
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            
            ScrollView{
                if !showFull{
                    
                    RowView(project: Project.example, nameSpace: nameSpace, showFull: $showFull)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                                    showFull.toggle()
                                }
                                
                            }
                    
                }
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {Color.clear.frame(height: 70)})
            if showFull{
                FullRowView(project: Project.example, nameSpace: nameSpace, showFull: $showFull)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ProjectsArray())
    }
}
