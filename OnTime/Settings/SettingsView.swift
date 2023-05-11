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
    @EnvironmentObject var dataManager:DataManager
    @State private var showingEditView = false
    @State private var inputImage:UIImage? = UIImage(named: "default")
    @State private var name = "Unknown"
    @State private var email = "unknown@email.com"
    
    @State private var showScan = false
    @State private var showShareView = false
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    showScan = true
                }label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title)
                }
                .padding(.horizontal)
            }
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
                    
                    Button{
                        showShareView = true
                    }label: {
                        HStack{
                         Image(systemName: "square.and.arrow.up")
                            Text("Share Projects")
                        }
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
            CodeScannerView(codeTypes:[.qr],showViewfinder: true, shouldVibrateOnSuccess:true, completion: handleScan)
        }
        .sheet(isPresented: $showShareView,onDismiss: dataManager.fetchProjects){
            ShareView(allProjects: projects.projects)
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
                        let notUsedBefore = decodedData.filter{ !checkIfUsed(newProject: $0)}
                        for decodedProject in notUsedBefore{
                            
                            let imageData = projects.settings.image.image().jpegData(compressionQuality: 0.75)
                            let imageString = imageData?.base64EncodedString() ?? ""
                            let user = User(name: projects.settings.name, email: projects.settings.email, image:imageString)
                            
                            if var sharedProject = dataManager.sharedProjects.first(where: {UUID(uuidString: $0.id) == decodedProject.id}){
                                
                                sharedProject.users.append(user)
                                var sharedProjectsdictionary = ["id":sharedProject.id,"users":dataManager.arrayToDictionaries(sharedProject.users)] as [String : Any]
                                
                                
                                dataManager.updateDocumentData(documentID: sharedProject.id, newData: sharedProjectsdictionary)
                            }
                                projects.projects.append(decodedProject)
                            
                        }
                        projects.saveProjects()
                        
                    }
                }
            }
        case .failure(let error):
            print("scanning Error \(error.localizedDescription)")
        }
        
    }
    
    func checkIfUsed(newProject:Project)->Bool{
        projects.projects.contains(where: {$0.id == newProject.id})
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ProjectsArray())
    }
}

