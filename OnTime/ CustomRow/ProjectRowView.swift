//
//  ProjectRowView.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import SwiftUI

struct ProjectRowView: View {
    var project:Project
    
    @State var colors:[Color] = [.green,.blue,.cyan,.indigo,.pink,.purple,.red]
    
    var color:Color{
        colors.first!
    }
    
    var width = UIScreen.main.bounds.width
    var height =  UIScreen.main.bounds.height
    
    @Namespace var nameSpace
    
    @State private var showFull = false
    
    var body: some View {
        ZStack{
            if !showFull{
               
            }else{
                
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6,dampingFraction: 0.8)) {
                showFull.toggle()
            }
           
        }
        .onAppear{
            withAnimation {
                colors.shuffle()
            }
            
        }
        
    
}
}

struct ProjectRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRowView(project: Project.example)
    }
}
