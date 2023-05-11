//
//  RowView.swift
//  OnTime
//
//  Created by aplle on 5/3/23.
//

import SwiftUI

struct RowView: View {
    var project:Project
    
    
    var nameSpace:Namespace.ID
    
    @EnvironmentObject var dataManager:DataManager
    
    @Binding var showFull:Bool
    @Binding var showaddView:Bool
   
   
   var color:LinearGradient
   
    var deleting:(Project)->Void
   
    
    @State private var offset = CGSize.zero
    @State private var showDelete = false
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                
                VStack(alignment: .leading, spacing: 12){
                    VStack(alignment: .leading, spacing: 12){
                        HStack{
                            Text(project.name)
                                .font(.largeTitle.weight(.bold))
                                .matchedGeometryEffect(id: "\(project.name)name", in: nameSpace)
                                .frame(maxWidth:.infinity,alignment: .leading)
                            Spacer()
                            HStack{
                                Circle()
                                    .fill(project.checkColorOfStatusCircl)
                                    .frame(width: 12,height: 12)
                                    .matchedGeometryEffect(id: "\(project.name)statusCircle", in: nameSpace)
                                
                                Text(project.status)
                                    .foregroundColor(project.checkColorOfStatusCircl)
                                    .matchedGeometryEffect(id: "\(project.name)statusText", in: nameSpace)
                            }
                           
                        }
                        CustomProgressViewTasks(made: project.madeTasks.count, total: project.tasks.count)
                            .matchedGeometryEffect(id: "\(project.name)made", in: nameSpace)
                          
                        
                        
                    }
                    .padding(.horizontal,20)
                    .padding(.top,20)
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(project.tags,id:\.self){tag in
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 30).fill(.white)
                                        .frame(height:30)
                                    Text(tag)
                                        .foregroundColor(.black)
                                        .padding(.horizontal,10)
                                }
                            }
                        }
                        .padding(.horizontal,20)
                        
                    }
                    .padding(.vertical,9)
                    
                    
                    .matchedGeometryEffect(id: "\(project.name)tags", in: nameSpace)
                    
                }
                
                
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    
                        .matchedGeometryEffect(id: "\(project.name)blur", in: nameSpace)
                    
                )
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            withAnimation {
                                offset = gesture.translation
                            }
                           
                        }
                        .onEnded { gesture in
                            if gesture.translation.width < -50 {
                                withAnimation {
                                    offset.width = -40
                                    showDelete = true
                                }
                              
                            } else {
                           
                                withAnimation {
                                    showDelete = false
                                    offset = .zero
                                    
                                }
                               
                            }
                        }
                )
            }
            
            .foregroundStyle(.white)
            .background(
                color.matchedGeometryEffect(id: "\(project.name)BackgroundColor", in: nameSpace)
            )
            .mask{
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .matchedGeometryEffect(id: "\(project.name)mask", in: nameSpace)
            }
            .overlay(alignment: .topLeading){
                Image(systemName: project.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(project.isFavourite ? .red : .gray)
                    .font(.system(size: 30))
                    .padding(15)
                    .matchedGeometryEffect(id: "\(project.name)heart", in: nameSpace)
            }
            .overlay(alignment:.topTrailing){
                UsersCircleImage(users: findUsers(of: project))
                    .matchedGeometryEffect(id: "\(project.name)users", in: nameSpace)
                    .padding(.vertical,10)
                    .padding(.horizontal,60)
                
            }
            .frame(height: 300)
            .padding(30)
            .offset(x: offset.width)
            
            if showDelete{
                HStack{
                    Spacer()
                    Button{
                        withAnimation {
                            offset = .zero
                            deleting(project)
                            showDelete = false
                        }
                       
                    }label: {
                        Image(systemName: "trash.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        
    }
    
    func findUsers(of project:Project)->[User]{
        if  let sharedProject =  dataManager.sharedProjects.first(where: {$0.id == project.id.uuidString}){
            let users = sharedProject.users
            return users
        }
        return [User]()
    }
   
}

struct RowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        RowView(project: Project.example,nameSpace: namespace, showFull: .constant(true), showaddView: .constant(false), color: Color.randomColor()){_ in
            
        }
        .environmentObject(DataManager())
    }
}
