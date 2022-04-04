//
//  TrainerExerciseView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 3/31/22.
//

import SwiftUI

struct TrainerExerciseView: View {
    
    var user: UserDetails
    @StateObject var trainerModel = TrainerViewModel()
    
    var body: some View {
        VStack{
            List(trainerModel.userExerciseList) { item in
                Text(item.exerciseName + "\n" + item.exerciseDetails)
            }.listRowSeparatorTint(.black)
        }.padding()
            .onAppear(){
                trainerModel.getUserExercise(userId: user.userId)
            }
            .navigationBarTitle("Exercises", displayMode: .inline)
    }
}

struct TrainerExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerExerciseView(user: UserDetails(id: "imvwoni134", coach: "Darlin", userName: "genericusername", userType: "userType", userId: "imvwoni134"))
    }
}
