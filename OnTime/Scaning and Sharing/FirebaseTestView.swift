//
//  FirebaseTestView.swift
//  OnTime
//
//  Created by aplle on 5/10/23.
//

import SwiftUI

struct FirebaseTestView: View {
    @EnvironmentObject var dataManager:DataManager
   
    var body: some View {
        VStack{
            List(dataManager.sharedProjects, id: \.id){project in
                Text(project.id)
                Text("\(project.users.count)")
            }
            Button("Add"){
             
            }
        }
    }
}

struct FirebaseTestView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseTestView()
            .environmentObject(DataManager())
    }
}
