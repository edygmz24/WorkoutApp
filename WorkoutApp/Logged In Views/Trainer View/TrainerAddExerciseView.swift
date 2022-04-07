//
//  TrainerAddExerciseView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 4/3/22.
//

import SwiftUI

struct TrainerAddExerciseView: View {
    
    @StateObject var trainerViewModel = TrainerViewModel()
    
    @Environment(\.presentationMode)  var presentationMode
    
    var numberOfExercises : Int
    
    var userId : String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise")) {
                    TextField("Exercise Name", text: $trainerViewModel.userExericse.exerciseName)
                    TextField("Exercise Details", text: $trainerViewModel.userExericse.exerciseDetails)
                }
            }
            .navigationBarTitle("New Exercise", displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarItems(
                leading: Button(action: {
                    cancelledTapped()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    submitTapped()
                }, label: {
                    Text("Submit")
                }))
        }
    }
    
    func cancelledTapped(){
        dismiss()
    }

    func submitTapped(){
        trainerViewModel.submitExercise(userId: userId, numberOfExercise: numberOfExercises)
        dismiss()
    }

    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }

}

struct TrainerAddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerAddExerciseView(numberOfExercises: 4, userId: "randomId")
    }
}
