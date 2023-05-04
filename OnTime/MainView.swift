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
    @State  var selected:Project?
    @State var selectedColor:LinearGradient?
    @State  var showFull = false
    
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            
            ScrollView{
             
                ForEach(Projects.example.indices){index in
                        let selectedcolor = Color.randomColor()
                        
                    RowView(project: Projects.example[index], nameSpace: nameSpace, showFull: $showFull,color: selectedcolor)
                            
                            .opacity(showFull ? 0:1)
                            .shadow(radius: 40)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        selected = Projects.example[index]
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
                    if  let selectedColor = selectedColor{
                        let projectBinding = Binding<Project>(
                            get: { self.selected ?? Project.example},
                                    set: { self.selected = $0 }
                                )
                        FullRowView(project: projectBinding, nameSpace: nameSpace,color: selectedColor){
                            saveSelected()
                            showFull = false
                            
                        }
                    }
                }
            }
        }
    }
    func saveSelected(){
        if let selected = selected{
            
            if let indexOfSelected = Projects.example.firstIndex(where: {$0.id == selected.id}){
                
                Projects.example[indexOfSelected] = selected
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
