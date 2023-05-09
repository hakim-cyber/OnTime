//
//  MainView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI
enum Filters{
    case all,done,OnGoing,ToDo
}

struct MainView: View {
    @EnvironmentObject var Projects:ProjectsArray
    
    @Environment(\.colorScheme) var colorSheme
    var showFavourite:Bool?
    var showingFull:()->Void
    
    @State var filter = Filters.all
    
    @Namespace var nameSpace
    @State  var selected:Int?
    @State var selectedColor:LinearGradient?
    @State  var showFull = false
    @Binding var showAddView:Bool
    
    var body: some View {
        ZStack{
            
       
            
            ScrollView( showsIndicators: false){
               
                    VStack{
                        Text("Main")
                            .font(.system(.largeTitle, design: .monospaced))
                            .fontWeight(.black)
                            .padding()
                       
                    }
                
               
                ForEach(Array(Projects.projects.indices.sorted{Projects.projects[$0].statusFIlterInt > Projects.projects[$1].statusFIlterInt}) , id: \.self){index in
                        let selectedcolor = Color.randomColor()
                        
                    RowView(project: Projects.projects[index], nameSpace: nameSpace, showFull: $showFull,showaddView: $showAddView, color: selectedcolor){ deletedProject in
                        withAnimation {
                            Projects.deleteProject(project: deletedProject)
                        }
                       
                    }
                            
                            .opacity(showFull ? 0:1)
                            .shadow(color: .gray,radius: 5)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.3)){
                                    selected = index
                                    selectedColor = selectedcolor
                                    showingFull()
                                    showFull = true
                                }
                                
                            }
                        
                        
                    }
                
                
            }
           
            if showFull{
                if selected != nil{
                    if  let selectedColor = selectedColor{
                      
                                
                        FullRowView(showaddView: $showAddView,project: $Projects.projects[selected!], nameSpace: nameSpace,color: selectedColor){
                            withAnimation(.easeOut(duration: 0.3)){
                                saveSelected()
                                showingFull()
                                showFull = false
                            }
                            
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
                .preferredColorScheme(.light)
                .environmentObject(Projects)
       
        }
    }
    func saveSelected(){
        if let selected = selected{
                
            Projects.projects[selected] =  Projects.projects[selected]
                Projects.saveProjects()
            
        }
    }
    var projectsArray:[Project]{
        if showFavourite!{
            return Projects.favoritesArray
        }else{
            return Projects.projects
        }
    }
   
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView( showingFull: {}, showAddView: .constant(false))
            .environmentObject(ProjectsArray())
    }
}
