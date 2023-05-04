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
    @Published var projects = [Project]()
    var example = [Project(name: "New ", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")]),Project(name: "New 2", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")]),Project(name: "New 3", description: "Make An App",tasks: [Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar"),Task(name: "Hakim", description: "Omar")])]
    var favoritesArray:[Project]{
        return projects.filter{$0.isFavourite}
    }
}
