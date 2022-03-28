//
//  MainView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 3/4/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        NavigationView{
            if viewModel.userType == "Paid Client"{
                UserTabView()
            } else {
                TrainerView()
            }
        }.onAppear(){
            print("Main View user type " + viewModel.userType)
            print("Condition: " + String(String(viewModel.userType) == "Paid Client"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppViewModel())
    }
}
