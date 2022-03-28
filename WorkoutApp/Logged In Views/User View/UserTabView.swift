//
//  UserTabView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 2/21/22.
//

import SwiftUI

struct UserTabView: View {
    var body: some View {
        TabView{
            UserDashboardView()
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("Dashboard")
                }
            DailyWorkoutView()
                .tabItem{
                    Image(systemName: "figure.walk")
                    Text("Daily Workout")
                }
            UserProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Dashboard")
                }
        }
    }
}

struct UserTabView_Previews: PreviewProvider {
    static var previews: some View {
        UserTabView().environmentObject(AppViewModel())
    }
}
