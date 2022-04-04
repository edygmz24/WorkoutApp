//
//  TrainerView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 3/4/22.
//

import SwiftUI

struct TrainerView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var trainerModel = TrainerViewModel()
    
    var body: some View {
        VStack{
            HStack{
                Text(trainerModel.trainerName)
                Spacer()
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("Sign Out")
                        .foregroundColor(Color.white)
                        .frame(width: 90, height: 30)
                        .background(Color.blue)
                })
                    .cornerRadius(10)
            }
            
            List(trainerModel.userList){ item in
                NavigationLink(destination: TrainerExerciseView(user: item), label: {
                    Text(item.userName)
                })
            }.listRowSeparatorTint(.black)
            
            Spacer()
        } .padding()
        .onAppear(){
            trainerModel.getTrainerName()
            trainerModel.getUsers()
        }
        .navigationBarTitle("Clients", displayMode: .inline)
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView().environmentObject(AppViewModel())
    }
}
