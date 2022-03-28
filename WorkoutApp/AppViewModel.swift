//
//  AppViewModel.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 3/4/22.
//

import Foundation
import Firebase
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var userType = ""
    @Published var triggerSignInView = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let user = authResult.user
            print("signed in user email: \(user.email ?? "")")
            let doc = try await Firestore.firestore().collection("Users").document(user.uid).getDocument().data()
            self.userType = doc?["userType"] as! String
            print("User Type is " + self.userType)
            print("Sign in condition: " + String(self.userType=="Paid Client"))
            self.signedIn = true
            self.triggerSignInView = false
        }
        catch {
            print(error)
        }
    }
    
    @MainActor
    func signUp(email: String, password: String, fullName: String) async {
        do {
            let authResult = try await auth.createUser(withEmail: email, password: password)
            let user = authResult.user
            print("signed in user email: \(user.email ?? "")")
            let doc = try await Firestore.firestore().collection("Users").document(user.uid).getDocument().data()
            self.userType = doc?["userType"] as! String
            print("User Type is " + self.userType)
            print("Sign in condition: " + String(self.userType=="Paid Client"))
            self.signedIn = true
            self.triggerSignInView = false
        }
        catch {
            print(error)
        }
    }
    
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
        self.triggerSignInView = true
    }
    
    @MainActor
    func getUserType() async {
        
        do{
            var userId = ""
            if Auth.auth().currentUser != nil {
                userId = auth.currentUser?.uid ?? ""
            }
            print("User ID is: " + userId)
            let doc = try await Firestore.firestore().collection("Users").document(userId).getDocument().data()
            let userObj = UserDetails(id: doc?["userId"] as! String, coach: doc?["coach"] as! String, userName: doc?["userName"] as! String, userType: doc?["userType"] as! String, userId: doc?["userId"] as! String)
            
            self.userType = userObj.userType
        }
        catch {
            print(error)
        }
    }
}
