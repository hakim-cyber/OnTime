//
//  FullRowView.swift
//  OnTime
//
//  Created by aplle on 5/3/23.
//

import SwiftUI

struct FullRowView: View {
    @Binding var showaddView:Bool
    @Binding var project:Project
    
    var nameSpace:Namespace.ID
    var color:LinearGradient
    var close:()-> Void
    
    var body: some View {
        GeometryReader{geo in
            
            ZStack {
                
                ScrollView {
                    cover
                    
                    
                    
                }
                .background(color.matchedGeometryEffect(id: "\(project.name)BackgroundColor", in: nameSpace))
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing){
                    Button{
                        withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                
                                close()
                            }
                        }
                    }label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(.ultraThinMaterial,in:Circle())
                            .padding(.horizontal,30)
                            .padding(.vertical,50)
                            .ignoresSafeArea()
                        
                    }
                }
                .overlay(alignment:.topLeading){
                    Toggle("", isOn: $project.isFavourite)
                        .labelsHidden()
                        .toggleStyle(HeartToggleStyle(size: 30))
                        .matchedGeometryEffect(id: "\(project.name)heart", in: nameSpace)
                        .padding(.horizontal,30)
                        .padding(.vertical,55)
                        .ignoresSafeArea()
                       
                    
                }
                
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        ForEach(Array(project.tasks.indices.sorted{project.tasks[$0].MadeSortInt < project.tasks[$1].MadeSortInt }),id:\.self){index in
                            TasksListRow(color: color, task: $project.tasks[index])
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                
                .padding()
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 40,style: .continuous))
                    
                )
                .padding(.horizontal,10)
                .frame(height: 560)
                .position(x: geo.size.width/2, y: geo.size.height/1.35)
                
                
            }
        }
           
        
        
    }
    var cover: some View{
        VStack{
           Spacer()
          
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .foregroundStyle(.white)
        
        .mask{
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .matchedGeometryEffect(id: "\(project.name)mask", in: nameSpace)
        }
     
        .overlay(
            VStack(alignment: .center){
            ZStack{
                VStack{
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
                                
                                Text(project.status)
                                    .foregroundColor(project.checkColorOfStatusCircl)
                            }
                            .matchedGeometryEffect(id: "\(project.name)status", in: nameSpace)
                        }
                        CustomProgressViewTasks(made: project.madeTasks.count, total: project.tasks.count)
                            .matchedGeometryEffect(id: "\(project.name)made", in: nameSpace)
                        HStack{
                            Text("\(project.endTime .formatted(date: .numeric, time:.omitted))")
                                .font(.callout.weight(.light))
                            Text("|  \(project.endTime .formatted(date: .omitted,time: .shortened))")
                                .font(.callout.weight(.light))
                        }
                        .matchedGeometryEffect(id: "\(project.name)date", in: nameSpace)
                        HStack{
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
                            }
                          
                            .matchedGeometryEffect(id: "\(project.name)tags", in: nameSpace)
                            
                            Spacer()
                            Button{
                                withAnimation {
                                    showaddView = true
                                }
                             
                            }label: {
                                Image(systemName: "plus")
                                    .font(.title3.weight(.bold))
                                    .foregroundColor(.secondary)
                                    .padding(8)
                                    .background(.ultraThinMaterial,in:Circle())
                                   
                            }
                           
                            
                        }
                        Text(project.description)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    .padding(20)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                            .matchedGeometryEffect(id: "\(project.name)blur", in: nameSpace)
                    )
                    .padding(.vertical,20)
                    .padding(.horizontal,10)
                   
                      
                        
                    
                }
            
               
              
                   
                        
                       
                        
                
            }
                .offset(y:80)
                
            }
        )
   
 
    }
    
}

struct FullRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        FullRowView(showaddView: .constant(false), project: .constant(Project.example), nameSpace: namespace, color: Color.randomColor(), close: {})
            
        
    }
}
