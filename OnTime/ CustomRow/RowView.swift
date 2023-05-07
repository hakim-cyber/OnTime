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
    
    @Binding var showFull:Bool
    @Binding var showaddView:Bool
   
   var color:LinearGradient
    var body: some View {
        
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
                        
                        Text(project.status)
                            .foregroundColor(project.checkColorOfStatusCircl)
                    }
                    .matchedGeometryEffect(id: "\(project.name)status", in: nameSpace)
                }
                Text("\(project.madeTasks.count)/\(project.tasks.count) Tasks")
                    .font(.title3.weight(.semibold))
                    .matchedGeometryEffect(id: "\(project.name)madeText", in: nameSpace)
                
                
                HStack{
                    Text("\(project.endTime .formatted(date: .numeric, time:.omitted))")
                        .font(.callout.weight(.light))
                    Text("|  \(project.endTime .formatted(date: .omitted,time: .shortened))")
                        .font(.callout.weight(.light))
                }
                .matchedGeometryEffect(id: "\(project.name)date", in: nameSpace)
                
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
                    .padding(.horizontal,10)
                   
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
        .frame(height: 270)
        .padding(30)
        
        
    }
   
}

struct RowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        RowView(project: Project.example,nameSpace: namespace, showFull: .constant(true), showaddView: .constant(false), color: Color.randomColor())
    }
}
