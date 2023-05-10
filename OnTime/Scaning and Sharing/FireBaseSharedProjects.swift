//
//  FireBase.swift
//  OnTime
//
//  Created by aplle on 5/10/23.
//

import Foundation

struct User:Codable{
    let name:String
    let email:String
    let image:String
    
    func toDictionary() -> [String: Any] {
           return [
               "name": name,
               "email": email,
               "image": image
           ]
       }
    
}

struct SharedProject:Codable{
    let id:String
    var users = [User]()
}
