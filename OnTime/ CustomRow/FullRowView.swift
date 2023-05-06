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
                        .padding(.horizontal,30)
                        .padding(.vertical,55)
                        .ignoresSafeArea()
                    
                }
                
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        ForEach(Array(project.tasks.indices),id:\.self){index in
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
                .frame(height: 600)
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
                        
                        Text(project.name)
                            .font(.largeTitle.weight(.bold))
                            .matchedGeometryEffect(id: "\(project.name)name", in: nameSpace)
                            .frame(maxWidth:.infinity,alignment: .leading)
                        
                        Text("\(project.madeTasks.count)/\(project.tasks.count) Tasks")
                            .font(.title3.weight(.semibold))
                            .matchedGeometryEffect(id: "\(project.name)madeText", in: nameSpace)
                        Text(project.description)
                            .font(.footnote.weight(.light))
                            .matchedGeometryEffect(id: "\(project.name)description", in: nameSpace)
                        
                        
                        
                        
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
            
               
              
                   
                        Button{
                            withAnimation {
                                showaddView = true
                            }
                         
                        }label: {
                            Image(systemName: "plus")
                                .font(.largeTitle.weight(.bold))
                                .foregroundColor(.secondary)
                                .padding(15)
                                .background(.ultraThinMaterial,in:Circle())
                                .matchedGeometryEffect(id: "\(project.name) add Button", in: nameSpace)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                       
                        .offset(y:70)
                        
                
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
