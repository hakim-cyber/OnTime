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
    @State private var selected:Project?
    @State var selectedColor:LinearGradient?
    @State  var showFull = false
    
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            
            ScrollView{
             
                    ForEach(Projects.example){project in
                        let selectedcolor = Color.randomColor()
                        
                        RowView(project: project, nameSpace: nameSpace, showFull: $showFull,color: selectedcolor)
                            
                            .opacity(showFull ? 0:1)
                            .shadow(radius: 40)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        selected = project
                                        selectedColor = selectedcolor
                                        
                                        showFull = true
                                    }
                                }
                                
                            }
                        
                        
                    }
                
                
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {Color.clear.frame(height: 70)})
            if showFull{
                if let selected = selected{
                    if let selectedColor = selectedColor{
                        FullRowView(project: selected, nameSpace: nameSpace,color: selectedColor){
                            
                            showFull = false
                            
                        }
                    }
                }
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
