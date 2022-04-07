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
    @State private var presentDeleteAction = false
    
    var body: some View {
        VStack{
            List(trainerModel.userExerciseList) { item in
                Text(item.exerciseName + "\n" + item.exerciseDetails)
            }.listRowSeparatorTint(.black)
            Spacer()
            Button(action: {
                presentDeleteAction.toggle()
                
            }, label: {
                Text("Delete All")
                    .foregroundColor(Color.white)
                    .frame(width: 90, height: 30)
                    .background(Color.blue)
            }) .cornerRadius(10)
                .actionSheet(isPresented: $presentDeleteAction){
                    ActionSheet(title: Text("Delete"), message: Text("Are you sure you want to delete all exercises?"), buttons: [
                        .default(Text("Confirm"), action: {
                            trainerModel.deleteExercises(userId: user.userId)
                            trainerModel.getUserExercise(userId: user.userId)
                        }),
                        .cancel()
                    ])
                }
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
                        .sheet(isPresented: $presentAddNewExercise, onDismiss: {
                            trainerModel.getUserExercise(userId: user.userId)
                        }) {
                            TrainerAddExerciseView(numberOfExercises: trainerModel.userExerciseList.count, userId: user.userId)
                        }
                    }
            }
            
    }
}

struct TrainerExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerExerciseView(user: UserDetails(id: "imvwoni134", coach: "Darlin", userName: "genericusername", userType: "userType", userId: "imvwoni134"))
    }
}
