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
    
    var madeTasks:[Task]{
        tasks.filter{$0.isMade}
    }
   
    
    static let example = Project(name: "New ajsajshashaas", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")])
    
}
struct Task:Codable,Identifiable{
    var id = UUID()
    let name:String
    var description:String
    var isMade = false
}


class ProjectsArray:ObservableObject{
    let saveKey = "Projects"
    @Published var projects = [Project]()
   @Published var example = [Project(name: "New ", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")]),Project(name: "New 2", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")]),Project(name: "New 3", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")])]
    var favoritesArray:[Project]{
        return projects.filter{$0.isFavourite}
    }
    init(){
        loadProjects()
    }
    func saveProjects(){
       
        if let encoded = try? JSONEncoder().encode(projects){
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func loadProjects(){
        if let data = UserDefaults.standard.data(forKey: saveKey){
            if let decoded = try? JSONDecoder().decode([Project].self, from: data){
                projects = decoded
            }
        }
    }
}
