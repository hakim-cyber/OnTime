//
//  MainView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var Projects:ProjectsArray
    
    var showingFull:()->Void
    
    @Namespace var nameSpace
    @State  var selected:Int?
    @State var selectedColor:LinearGradient?
    @State  var showFull = false
    @Binding var showAddView:Bool
    
    var body: some View {
        ZStack{
           
            
            ScrollView( showsIndicators: false){
             
                ForEach(Array(Projects.projects.indices) , id: \.self){index in
                        let selectedcolor = Color.randomColor()
                        
                    RowView(project: Projects.projects[index], nameSpace: nameSpace, showFull: $showFull,showaddView: $showAddView, color: selectedcolor)
                            
                            .opacity(showFull ? 0:1)
                            .shadow(radius: 40)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        selected = index
                                        selectedColor = selectedcolor
                                        showingFull()
                                        showFull = true
                                    }
                                }
                                
                            }
                        
                        
                    }
                
                
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {Color.clear.frame(height: 70)})
            if showFull{
                if selected != nil{
                    if  let selectedColor = selectedColor{
                      
                                
                        FullRowView(showaddView: $showAddView,project: $Projects.projects[selected!], nameSpace: nameSpace,color: selectedColor){
                            saveSelected()
                            showingFull()
                            showFull = false
                            
                        }
                        .preferredColorScheme(.dark)
                    }
                }
            }
        }
        .onAppear{
            Projects.loadProjects()
        }
        .fullScreenCover(isPresented: $showAddView){
           
                AddView( ){
                    
                    Projects.saveProjects()
                    Projects.loadProjects()
                    
                }
                .environmentObject(Projects)
       
        }
    }
    func saveSelected(){
        if let selected = selected{
                
            Projects.projects[selected] =  Projects.projects[selected]
                Projects.saveProjects()
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView( showingFull: {}, showAddView: .constant(false))
            .environmentObject(ProjectsArray())
    }
}
