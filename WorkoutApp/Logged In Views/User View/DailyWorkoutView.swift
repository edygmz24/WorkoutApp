//
//  DailyWorkoutView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 2/21/22.
//

import SwiftUI

struct DailyWorkoutView: View {
    @ObservedObject var exerciseView = ExerciseViewModel()
    
    var body: some View {
        VStack{
            Text("Exercises")
            List(exerciseView.list){ item in
                Text(item.exerciseName + "\n" +
                     item.exerciseDetails)
                    //.padding()
                //Text(item.exerciseDetails)
                    //.padding()
            }.listRowSeparatorTint(.black)
            
        }.edgesIgnoringSafeArea(.top)
        .padding()
            .onAppear(){
                exerciseView.getExercises()
            }
    }
}

struct DailyWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWorkoutView().environmentObject(AppViewModel())
    }
}
