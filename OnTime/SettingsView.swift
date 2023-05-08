//
//  SettingsView.swift
//  OnTime
//
//  Created by aplle on 5/8/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var projects:ProjectsArray
    @State private var showingEditView = false
    @State private var inputImage:UIImage? = UIImage(named: "default")
    @State private var name = "Unknown"
    @State private var email = "unknown@email.com"
    var body: some View {
        VStack{
            VStack(alignment: .center){
                Image(uiImage: inputImage!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 80,height: 80)
                    .onTapGesture {
                        showingEditView = true
                    }
                 Text(name)
                    .font(.title.weight(.bold))
                Text(email)
                   .font(.caption.weight(.semibold))
                   .foregroundColor(.secondary)
                Button{
                    showingEditView = true
                }label: {
                    HStack{
                        Text("Edit Profile")
                            .padding(4)
                            .foregroundColor(.white)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
                    .background(.blue)
                    .clipShape(Capsule())
                    
                }
            }
            .padding()
            Spacer()
            Form{
                Section("Content"){
                    Text("Coming Soon...")
                }
               
                Section("Preferences"){
                    Text("Coming Soon....")
                }
            }
        
        }
      
      
        .sheet(isPresented: $showingEditView,onDismiss: {saveSettings()}){
            SettingsEditView(email: $email, name: $name, image: $inputImage)
                    }
        .onAppear{
            
            loadSettings()
        }
    }
    
    func saveSettings(){
        projects.settings.image = ImageWrapper(inputImage!)
        projects.settings.name  = name
        projects.settings.email = email
        
        projects.saveSettings()
    }
    func loadSettings(){
        projects.loadSettings()
        
        inputImage =  projects.settings.image.image()
       name = projects.settings.name
       email = projects.settings.email
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ProjectsArray())
    }
}

