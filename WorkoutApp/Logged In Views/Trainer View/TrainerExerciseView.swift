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
    
    @State private var presentAddNewExercise = false
    
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
            .toolbar{
                ToolbarItem{
                        Button(action: { presentAddNewExercise.toggle() }, label: {
                            Image(systemName: "plus")
                        })
                    }
            }
            .sheet(isPresented: $presentAddNewExercise){
                TrainerAddExerciseView(userId: user.userId)
            }
    }
}

struct TrainerExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerExerciseView(user: UserDetails(id: "imvwoni134", coach: "Darlin", userName: "genericusername", userType: "userType", userId: "imvwoni134"))
    }
}
