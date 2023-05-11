//
//  DataManager.swift
//  OnTime
//
//  Created by aplle on 5/10/23.
//

import Foundation
import SwiftUI
import Firebase

class DataManager:ObservableObject{
    private let db = Firestore.firestore()
    @Published var sharedProjects = [SharedProject]()
    static let uuid = UUID().uuidString
    init(){
        fetchProjects()
    }
    func arrayToDictionaries(_ users: [User]) -> [[String: Any]] {
            return users.map { $0.toDictionary() }
        }
    
  
     func ToArray(_ dict: [String:Any]) -> User{
        
        let nameOFUser = dict["name"] as? String ?? ""
        let emailOFUser = dict["email"] as? String ?? ""
        let imageOFUser = dict["image"] as? String ?? ""
        
        return User(name: nameOFUser, email: emailOFUser, image: imageOFUser)
    }
    func dictionaryToArray(_ dicts:[[String: Any]]) ->[User]{
        return dicts.map { ToArray($0) }
    }
    
    
    func saveSharedProject(_ sharedProject: SharedProject) {
           do {
               
               let arrayUsers = arrayToDictionaries(sharedProject.users)
               
               let ref = db.collection("SharedProjects").document(sharedProject.id)
               
               ref.setData(["id":sharedProject.id,"users":arrayUsers]){error in
                   if let error = error{
                       print(error.localizedDescription)
                   }
               }
               fetchProjects()
              
           } catch {
               print("Error saving shared project: \(error.localizedDescription)")
           }
       }
    
    func fetchProjects(){
        sharedProjects.removeAll()
        
        let ref = db.collection("SharedProjects")
        
        ref.getDocuments{ [self]snapshot,error in
            guard  error == nil else{
                print(error?.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let arrayOfDictioniesUser = data["users"] as? [[String: Any]] ?? []
                    
                   let sharedProject = SharedProject(id: id,users: dictionaryToArray(arrayOfDictioniesUser))
                    
                    sharedProjects.append(sharedProject)
                    
                }
            }
        }
    }
    func updateDocumentData(documentID: String, newData: [String: Any]) {
        let docRef = db.collection("SharedProjects").document(documentID)
        
        docRef.updateData(newData) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document updated successfully.")
            }
        }
        fetchProjects()
    }
    
    

}
