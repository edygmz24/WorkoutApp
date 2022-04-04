//
//  TrainerAddExerciseView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 4/3/22.
//

import SwiftUI

struct TrainerAddExerciseView: View {
    
    @StateObject var trainerViewModel = TrainerViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise")) {
                    TextField("Exercise Name", text: $trainerViewModel.userExericse.exerciseName)
                    TextField("Exercise Details", text: $trainerViewModel.userExericse.exerciseDetails)
                }
            }
        }
        .navigationTitle("New Exercise")
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
    
}

func submitTapped(){
    
}

struct TrainerAddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerAddExerciseView()
    }
}
