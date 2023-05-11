//
//  ShareView.swift
//  OnTime
//
//  Created by aplle on 5/9/23.
//

import SwiftUI

struct ShareView: View {
    var allProjects:[Project]
    @Environment(\.colorScheme) var colorScheme
    
    @State var selectedProjects = [Project]()
    @State private var showQrCodeView = false
    var body: some View {
        Form{
            List {
                      ForEach(allProjects, id: \.id) { project in
                          Toggle(project.name, isOn: Binding(
                            get: { selectedProjects.contains(where: {$0.id == project.id}) },
                              set: { isOn in
                                  if isOn {
                                      selectedProjects.append(project)
                                  } else {
                                      if let index = selectedProjects.firstIndex(where: {$0.id == project.id}) {
                                          selectedProjects.remove(at: index)
                                      }
                                  }
                              }
                          ))
                      }
                  }
            
        }
        .safeAreaInset(edge: VerticalEdge.bottom){
            Button{
                withAnimation{
                    showQrCodeView = true
                }
            }label: {
                Text("Create Qr Code")
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .foregroundColor(colorScheme == .light ? .white:.black)
                    .padding()
                    .background(colorScheme == .light ? .black :.white)
                    .cornerRadius(30)
                    .padding()
            }
            .disabled(selectedProjects.isEmpty)
        }
        .sheet(isPresented: $showQrCodeView){
            ScanView(projects: selectedProjects)
        }
        
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView(allProjects: [Project.example])
    }
}
