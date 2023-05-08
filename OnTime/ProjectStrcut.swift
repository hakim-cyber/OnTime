//
//  ProjectStrcut.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//
import SwiftUI
import Foundation


struct Project:Codable,Identifiable{
   
    var id = UUID()
    let name:String
    let description:String
    var tasks :[Task]
    var isFavourite = false
    var tags:[String] = []
    var endTime = Date()
    
    var madeTasks:[Task]{
        tasks.filter{$0.isMade == true}
    }
    var status:String{
        if tasks.count > 0{
            if (Double(madeTasks.count) / Double(tasks.count)) > 0 && (Double(madeTasks.count) / Double(tasks.count) ) < 1{
                return "In Progress"
            }else if madeTasks.count == tasks.count {
                return "Done"
            }else{
               
                return "To Do"
               
            }
        }else{
            return "To Do"
        }
    }
    var statusFIlterInt:Int{
        switch status{
        case  "To Do":
            return 1
        case "In Progress":
            return 2
        case  "Done":
            return 0
        default:
            return 0
        }
    }
    
    var checkColorOfStatusCircl: Color{
        if status == "In Progress"{
            return Color.blue
        }else if status == "Done"{
            return Color.green
        }else{
            return Color.gray
        }
    }
    static let example = Project(name: "New ajsajshashaas", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")])
    
}
struct Task:Codable,Identifiable{
    var id = UUID()
    let name:String
    var description:String
    var isMade = false
    
    var MadeSortInt:Int{
        switch isMade{
        case false:
            return 0
        case true:
            return 1
        }
    }
}
struct Settings:Codable{
    var name = "YourName"
    var image:ImageWrapper = ImageWrapper(UIImage(named: "default")!)
    var email:String = "unknown@email.com"
}

class ProjectsArray:ObservableObject{
    let saveKey = "Projects"
    let settingsSaveKey = "Settings"
    @Published var projects = [Project]()
    var favoritesArray:[Project]{
        return projects.filter{$0.isFavourite}
    }
    
@Published var settings = Settings()
    
    init(){
        loadProjects()
    }
    func saveProjects(){
        if let encoded = try? JSONEncoder().encode(projects){
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func saveSettings(){
      
        if let encoded = try? JSONEncoder().encode(settings){
            UserDefaults.standard.set(encoded, forKey: settingsSaveKey)
        }
    }
    func loadProjects(){
        if let data = UserDefaults.standard.data(forKey: saveKey){
            if let decoded = try? JSONDecoder().decode([Project].self, from: data){
                projects = decoded
            }
        }
    }
    func loadSettings(){
        if let data = UserDefaults.standard.data(forKey: settingsSaveKey){
            if let decoded = try? JSONDecoder().decode(Settings.self, from: data){
                settings = decoded
            }
        }
    }
}

struct Previews_ProjectStrcut_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
