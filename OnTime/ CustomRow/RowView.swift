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
                Text(project.name)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "\(project.name)name", in: nameSpace)
                    .frame(maxWidth:.infinity,alignment: .leading)
              
                    Text("\(project.madeTasks.count)/\(project.tasks.count) Tasks")
                        .font(.title3.weight(.semibold))
                        .matchedGeometryEffect(id: "\(project.name)madeText", in: nameSpace)
                   
                   
                HStack{
                    Text(project.description)
                        .font(.footnote.weight(.light))
                        .matchedGeometryEffect(id: "\(project.name)description", in: nameSpace)
                    
                    Spacer()
                    Button{
                        withAnimation {
                            showaddView = true
                        }
                     
                    }label: {
                        Image(systemName: "plus")
                            .font(.title.weight(.bold))
                            .foregroundColor(.secondary)
                            .padding(15)
                            .background(.ultraThinMaterial,in:Circle())
                            .matchedGeometryEffect(id: "\(project.name) add Button", in: nameSpace)
                    }
                    .padding(0)
                   
                }
                
            }
            .padding(20)
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
        .frame(height: 260)
        .padding(30)
        
        
    }
}

struct RowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        RowView(project: Project.example,nameSpace: namespace, showFull: .constant(true), showaddView: .constant(false), color: Color.randomColor())
    }
}
