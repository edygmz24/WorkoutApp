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
    @Published var userExerciseList = [ExerciseDetails]()
    @Published var userExericse = ExerciseDetails(id: "", exerciseName: "", exerciseDetails: "")
    @Published var totalExercises = 0
    
    func getTrainerName(){
        self.trainerName = Auth.auth().currentUser?.displayName ?? ""
    }
    
    func getUsers(){
        let db = Firestore.firestore()
        let coachName = Auth.auth().currentUser?.displayName ?? ""
        self.userList.removeAll()
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
        // print userId to console
        print("User Id fetched for caoch is: " + userId)
        
        //empty previous exercise array
        self.userExerciseList.removeAll()
        self.totalExercises = 0
        
        let db = Firestore.firestore()
        
        db.collection(userId+"_Exercise").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        snapshot.documents.forEach { doc in
                            let fetchedExercise = ExerciseDetails(id: doc.documentID, exerciseName: doc["exerciseName"] as? String ?? "", exerciseDetails: doc["exerciseDetails"] as? String ?? "")
                            
                            self.userExerciseList.append(fetchedExercise)
                        }
                        // update totalExercises with the size of the userExerciseList
                        self.totalExercises = self.userExerciseList.count
                        print("Total number of exercises: \(self.totalExercises)")
                        print("Exercises: \(String(describing: self.userExerciseList))")
                    }
                }
            } else {
                print("Error getting exercises. Error msg: \(String(describing: error))")
            }
        }
    }
    
    func addExercise(userExercise: ExerciseDetails, userId: String){
        
        let db = Firestore.firestore()
        var documentId = ""
        
        if self.totalExercises == 0 {
            documentId = "exercise_1"
        } else {
            documentId = "exercise_" + String(self.totalExercises+1)
        }
        
        db.collection(userId+"_Exercise").document(documentId).setData(["exerciseName": userExercise.exerciseName, "exerciseDetails": userExercise.exerciseDetails]) { err in
            if let err = err {
                print("Error saving exercise. Error msg: \(err)")
            } else {
                print("Exercise saved successfully.")
            }
        }
    }
    
    func submitExercise(userId: String){
        addExercise(userExercise: userExericse, userId: userId)
    }
}
