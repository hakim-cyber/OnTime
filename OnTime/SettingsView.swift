//
//  SettingsView.swift
//  OnTime
//
//  Created by aplle on 5/8/23.
//

import SwiftUI
import CodeScanner

struct SettingsView: View {
    @EnvironmentObject var projects:ProjectsArray
    @State private var showingEditView = false
    @State private var inputImage:UIImage? = UIImage(named: "default")
    @State private var name = "Unknown"
    @State private var email = "unknown@email.com"
    
    @State private var showScan = false
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
                    Button("Scan"){
                        showScan = true
                    }
                }
               
                Section("Preferences"){
                    Text("Coming Soon....")
                }
            }
        
        }
      
      
        .sheet(isPresented: $showingEditView,onDismiss: {saveSettings()}){
            SettingsEditView(email: $email, name: $name, image: $inputImage)
                    }
        .sheet(isPresented: $showScan){
           
            CodeScannerView(codeTypes:[.qr],completion: handleScan)
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
    
    func handleScan(result:Result<ScanResult,ScanError>){
        showScan = false
        
        switch result{
        case .success(let result):
            if let data = result.string.data(using: .utf8){
                if let decodedData = try? JSONDecoder().decode([Project].self, from: data) {
                    if !decodedData.isEmpty{
                        print(decodedData.first?.name)
                    }
                }
            }
        case .failure(let error):
            print("scanning Error \(error.localizedDescription)")
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ProjectsArray())
    }
}

