//
//  ExerciseViewModel.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 2/23/22.
//

import Foundation
import Firebase
import FirebaseAuth

class ExerciseViewModel : ObservableObject {
    
    @Published var list = [ExerciseDetails]()
    @Published var exercise : ExerciseDetails = ExerciseDetails(id: "", exerciseName: "", exerciseDetails: "")
    
    func getExercises(){
        
        // get the dbName
        let userID = Auth.auth().currentUser?.uid ?? ""
        let dbName = userID + "_Exercise"
        print("DB Name is: " + dbName)
        
        // Get a reference to the DB
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection(dbName).getDocuments { snapshot, error in
            // check for errors
            if error == nil {
                // no errors
                if let snapshot = snapshot {
                    // update the list property in the main thread
                    DispatchQueue.main.async {
                        // get all the docs and create list
                        self.list = snapshot.documents.map { doc in
                            // create an ExercideDetails item for each document returned
                            return ExerciseDetails(id: doc.documentID, exerciseName: doc["exerciseName"] as? String ?? "", exerciseDetails: doc["exerciseDetails"] as? String ?? "")
                        }
                    }
                }
                print("Exercises: ")
                print(self.list)
            } else {
                //handle the error
                print(error ?? "Error getting documents.")
            }
        }
    }
    
    func addExercises(exercise: ExerciseDetails){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid ?? ""
        let dbName = userID + "_Exercise"
        let listSize = self.list.count
        db.collection(dbName).document("exercise_" + String(listSize)).setData(["exerciseName": exercise.exerciseName, "exerciseDetails": exercise.exerciseDetails]) { err in
            if let err = err {
                print("Error writing documnet: \(err)")
            } else {
                print("Document successfully written.")
            }
        }
    }
}
