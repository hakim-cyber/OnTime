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
    
    @State var colors:[Color] = [.green,.blue,.cyan,.indigo,.pink,.purple,.red]
    
    var color:Color{
        colors.first!
    }
    var body: some View {
        
        ZStack {
            ScrollView {
                cover
                
            }
            .background(Color.backgroundColor)
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
        }
    }
    var cover: some View{
        VStack{
            Spacer()
           
          
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.white)
        .background(
            color.matchedGeometryEffect(id: "BackgroundColor", in: nameSpace)
        )
        .mask{
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .matchedGeometryEffect(id: "mask", in: nameSpace)
        }
        .overlay(
            VStack(alignment: .leading, spacing: 12){
                
                Text(project.name)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "name", in: nameSpace)
                .frame(maxWidth:.infinity,alignment: .leading)
                
                Text("\(project.madeTasks.count)/\(project.tasks.count) Tasks")
                    .font(.title3.weight(.semibold))
                    .matchedGeometryEffect(id: "madeText", in: nameSpace)
                Text(project.description)
                    .font(.footnote.weight(.light))
                    .matchedGeometryEffect(id: "description", in: nameSpace)
                Divider()
                HStack{
                    Button("Add"){
                        
                    }
                }
                Divider()
                List(project.tasks){task in
                    Text(task.name)
                        .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                
            }
                .padding(20)
                .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .matchedGeometryEffect(id: "blur", in: nameSpace)
                )
                .offset(y:250)
               
        )
    .padding(20)
    }
    
}

struct FullRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        FullRowView(project: Project.example, nameSpace: namespace, showFull: .constant(true))
    }
}
