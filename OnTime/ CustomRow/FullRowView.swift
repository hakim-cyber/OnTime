//
//  FullRowView.swift
//  OnTime
//
//  Created by aplle on 5/3/23.
//

import SwiftUI

struct FullRowView: View {
    var project:Project
    
    var nameSpace:Namespace.ID
    
    @Binding var showFull:Bool
    
  
    var color:Color
    
    var body: some View {
        
        ZStack {
            ScrollView {
                cover
         
                
                
            }
            .background(color)
            .ignoresSafeArea()
            Button{
                withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                    showFull.toggle()
                }
            }label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial,in:Circle())
                    
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
            .padding(30)
            .ignoresSafeArea()
            VStack{
                List(project.tasks){task in
                    Text(task.name)
                        .listRowBackground(Color.clear)
                        .padding(10)
                    
                }
                .listStyle(.plain)
                
            }
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 40,style: .continuous))
                   
            )
            .padding(.horizontal,10)
            .offset(y:400)
        }
    }
    var cover: some View{
        VStack{
           Spacer()
          
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .foregroundStyle(.white)
        .background(
            color.matchedGeometryEffect(id: "\(project.name)BackgroundColor", in: nameSpace)
               
        )
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
                            
                        }label: {
                            Image(systemName: "plus")
                                .font(.largeTitle.weight(.bold))
                                .foregroundColor(.secondary)
                                .padding(20)
                                .background(.ultraThinMaterial,in:Circle())
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                        .offset(y:70)
                
            }
                .offset(y:180)
                
            }
        )
   
 
    }
    
}

struct FullRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        FullRowView(project: Project.example, nameSpace: namespace, showFull: .constant(true),color: Color.indigo)
    }
}
