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
        List(exerciseView.list){ item in
            Text(item.exerciseName)
                .padding()
            Text(item.exerciseDetails)
                .padding()
        }
    }
}

struct DailyWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWorkoutView()
    }
}
