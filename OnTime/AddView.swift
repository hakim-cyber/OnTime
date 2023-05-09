//
//  AddView.swift
//  OnTime
//
//  Created by aplle on 5/5/23.
//

import SwiftUI
enum DateOfTask{
    case today,tomorrow,thisWeek,thisMonth,thisYear
}

struct AddView: View {
    
    @State var dateOfTask = DateOfTask.today
    var change:()->Void
    @EnvironmentObject var projects:ProjectsArray
    @Environment(\.colorScheme) var colorScheme

    @State var selectedProject:Project?
    @State private  var nameOfTask = ""
    @State private  var descriptionOfTask = ""
    
    @State private var newProjectName = ""
    @State private var newProjectDescription = ""
    
    @State private var showAlertNewProject = false
    @State private var showAlertNewTag = false
    @State private var Tags:[String] = []
    @State private var tag = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
           
                HStack{
                    VStack(alignment: .leading){
                        
                        Text("New Task")
                            .font(.system(.largeTitle, design: .monospaced))
                            .fontWeight(.black)
                            .padding()
                    }
                    Spacer()
                    RoundedButtonAddView(text: "", textColor: .black, backgroundColor: .white, action: {presentationMode.wrappedValue.dismiss()},image: "xmark")
                        .ignoresSafeArea()
                        .padding(.horizontal,20)
                        .offset(y:-20)
                }
                VStack{
                    VStack(alignment: .leading){
                        HStack{
                            RoundedButtonAddView(text: "Today", textColor: dateOfTask == .today ? .white : .black, backgroundColor: dateOfTask == .today ? .black : .white, action: {withAnimation{dateOfTask = .today}})
                            RoundedButtonAddView(text: "Tomorrow", textColor: dateOfTask == .tomorrow ? .white : .black, backgroundColor: dateOfTask == .tomorrow ? .black : .white, action: {withAnimation{dateOfTask = .tomorrow}})
                            Menu{
                                Button("This Week"){
                                    dateOfTask = .thisWeek
                                }
                                Button("This Month"){
                                    dateOfTask = .thisMonth
                                }
                                Button("This Year"){
                                    dateOfTask = .thisYear
                                }
                            }label: {
                                RoundedButtonAddView(text: "", textColor: .black, backgroundColor: .white, action: {},image: "ellipsis")
                            }
                           
                            Spacer()
                        }
                        HStack{
                            
                            RoundedButtonAddView(text: "", textColor: .black, backgroundColor: .white, action: {},image: "bell.badge")
                        }
                    }
                    .padding()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Projects")
                                .font(.system(.headline, design: .monospaced))
                                .fontWeight(.light)
                                .padding()
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    RoundedButtonAddView(text: "", textColor: .black, backgroundColor: .white, action: {showAlertNewProject = true},image: "plus")
                                    ForEach(projects.projects){project in
                                       
                                        RoundedButtonAddView(text: project.name, textColor: project.id == selectedProject?.id ? .white : .black, backgroundColor: project.id == selectedProject?.id ? .blue : .white, action: {selectedProject = project})
                                    }
                                }
                                .padding()
                            }
                            
                        }
                        Spacer()
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("Title")
                                .font(.system(.headline, design: .monospaced))
                                .fontWeight(.light)
                                .padding()
                            Text("Name")
                                .font(.system(.subheadline, design: .default))
                                .foregroundColor(.gray)
                                .fontWeight(.light)
                                .padding(.horizontal,10)
                            TextField("", text: $nameOfTask)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .shadow(color: colorScheme == .light ? .gray : .gray,radius: 5)
                                .padding(.horizontal,20)
                                .padding(.vertical,2)
                                .labelsHidden()
                            Text("Description (optional)")
                                .font(.system(.subheadline, design: .default))
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                                .padding(.horizontal,6)
                                .padding(5)
                            TextField("", text: $descriptionOfTask)
                                .padding()
                               
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .shadow(color: colorScheme == .light ? .gray : .white,radius: 5)
                                .padding(.horizontal,20)
                                .padding(.vertical,2)
                                .labelsHidden()
                            if selectedProject != nil{
                                Text("Tags")
                                    .font(.system(.subheadline, design: .default))
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal,6)
                                    .padding(5)
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        
                                        RoundedButtonAddView(text: "", textColor: .black, backgroundColor: .white, action: {showAlertNewTag = true},image: "plus")
                                        
                                        ForEach(selectedProject!.tags,id:\.self){tag in
                                            RoundedButtonAddView(text: tag, textColor: .white, backgroundColor: .green, action: {})
                                            
                                        }
                                    }
                                    .padding(.horizontal)
                                 
                                }
                                
                            }
                            
                        }
                      
                    }
                    
                }
            
        }
        .onAppear{
            if !(projects.projects.isEmpty){
                selectedProject = projects.projects[0]
                
            }
        }
        .alert("New Project", isPresented: $showAlertNewProject){
            
                        TextField("Title", text: $newProjectName)
                .foregroundColor(.gray)
                       TextField("Description", text: $newProjectDescription)

                .foregroundColor(.gray)
                        Button("Add", action: {addNewProject()})
                        Button("Cancel", role: .cancel, action: {})
        }
        .alert("New Tag", isPresented: $showAlertNewTag){
            
                        TextField("Title", text: $tag)
                .foregroundColor(.gray)
            Button("Add", action: {addNewTag()})
                        Button("Cancel", role: .cancel, action: {})
        }
        .safeAreaInset(edge: VerticalEdge.bottom){
            Button{
                withAnimation{
                    createTask()
                    presentationMode.wrappedValue.dismiss()
                }
            }label: {
                Text("Create")
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .foregroundColor(colorScheme == .light ? .white:.black)
                    .padding()
                    .background(colorScheme == .light ? .black :.white)
                    .cornerRadius(30)
                    .padding()
            }
            .disabled(nameOfTask == "" )
        }
    }
    func createTask(){
        if let selectedProject = selectedProject{
            if  let indexOfProject = projects.projects.firstIndex(where: {$0.id == selectedProject.id}){
                let task = Task(name: nameOfTask, description: descriptionOfTask)
                
                projects.projects[indexOfProject].tasks.append(task)
                projects.projects[indexOfProject].endTime = calculateDateOfTask()
                change()
            }
        }
    }
    func calculateDateOfTask()-> Date{
        let now = Date()
        let today = now + 43200
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
        let thisweek = Calendar.current.date(byAdding: .day, value: 7, to: now)!
        let thisMonth = Calendar.current.date(byAdding: .month, value: 1, to: now)!
        let thisYear = Calendar.current.date(byAdding: .year, value: 1, to: now)!
        
        switch dateOfTask {
        case .today:
            return today
        case .tomorrow:
            return tomorrow
        case .thisWeek:
            return thisweek
        case .thisMonth:
            return thisMonth
        case .thisYear:
            return thisYear
        }
       
    }
    func addNewProject(){
        let newProject = Project(name: newProjectName, description: newProjectDescription, tasks: [Task]())
        
        projects.projects.insert(newProject, at: 0)
        change()
       
        
        
        selectedProject = newProject
        
        newProjectName = ""
        newProjectDescription = ""
    }
    func addNewTag(){
        if selectedProject != nil{
            if let indexOfSelected =   projects.projects.firstIndex(where: {$0.id == selectedProject?.id}){
                selectedProject?.tags.append(tag)
                projects.projects[indexOfSelected].tags = (selectedProject)!.tags
                change()
            }
        }
        tag = ""
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(){
            
        }
            .environmentObject(ProjectsArray())
    }
}

struct RoundedButtonAddView: View {
    var text: String
    var textColor: Color
    var backgroundColor: Color
    var action: () -> Void
    var image:String?
    
    var body: some View {
        Button(action: action) {
            ZStack{
                if image == nil{
                    Text(text)
                        .foregroundColor(textColor)
                        .padding()
                        .padding(.horizontal,18)
                        .background(backgroundColor)
                        .cornerRadius(30)
                }else{
                    Image(systemName: image!)
                        .foregroundColor(textColor)
                        .padding()
                        .background(backgroundColor)
                        .cornerRadius(30)
                }
                
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(textColor, lineWidth: 1)
        )
       
    }
}
