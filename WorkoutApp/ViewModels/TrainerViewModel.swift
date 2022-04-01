//
//  ClientViewModel.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 3/31/22.
//

import Foundation
import Firebase
import FirebaseAuth

class TrainerViewModel : ObservableObject {
    @Published var userList = [UserDetails]()
    @Published var trainerName = ""
    
    func getTrainerName(){
        self.trainerName = Auth.auth().currentUser?.displayName ?? ""
    }
    
    func getUsers(){
        let db = Firestore.firestore()
        let coachName = Auth.auth().currentUser?.displayName ?? ""
        print("Coach name: " + coachName)
        
        // read the documents at a specific path
        db.collection("Users").getDocuments { snapshot, error in
            //check the errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    // update the userList property in the main thread
                    DispatchQueue.main.async {
                        // iterate through each document
                        snapshot.documents.forEach{ doc in
                            let fetchedUser = UserDetails(id: doc.documentID, coach: doc["coach"] as? String ?? "", userName: doc["userName"] as? String ?? "", userType: doc["userType"] as? String ?? "", userId: doc["userId"] as? String ?? "")
                            // if fetched user's coach name matches current signed in coach name the append user
                            // to list
                            if fetchedUser.coach == coachName{
                                self.userList.append(fetchedUser)
                            }
                        }
                    }
                }
            } else {
                print(error ?? "Error getting documents.")
            }
            
        }
    }
    
    func getUserExercise(userId: String){
        
    }
}
