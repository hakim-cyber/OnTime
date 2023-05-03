//
//  MainView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var Projects:ProjectsArray
  @State  var colors = [Color.red, Color.blue, Color.green, Color.orange, Color.yellow,Color.indigo]
    @Namespace var nameSpace
    @State private var selected:Project?
    @State var selectedColor:Color?
    @State  var showFull = false
    
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            
            ScrollView{
                if !showFull{
                    ForEach(Projects.example){project in
                        let selectedcolor = colors.randomElement()!
                        
                            RowView(project: project, nameSpace: nameSpace, showFull: $showFull,color: selectedcolor)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                                        selected = project
                                        selectedColor = selectedcolor
                                        showFull.toggle()
                                    }
                                    
                                }
                                .shadow(radius: 40)
                        
                           
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {Color.clear.frame(height: 70)})
            if showFull{
                if let selected = selected{
                    if let selectedColor = selectedColor{
                        FullRowView(project: selected, nameSpace: nameSpace, showFull: $showFull,color: selectedColor)
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
