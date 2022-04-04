//
//  ContentView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 2/20/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Image("appLogo")
                    .resizable()
                    .scaledToFit()
                Spacer()
                NavigationLink("Continue", destination: InitialView())
                    .navigationBarTitle("Workout App", displayMode: .inline)
                    //.navigationBarHidden(true)
            }.onAppear {
                viewModel.signedIn = viewModel.isSignedIn
                if viewModel.signedIn {
                    Task {
                        await viewModel.getUserType()
                    }
                }
                print("Content View user type: " + viewModel.userType )
            }
        }
    }
}

struct InitialView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View{
        if viewModel.signedIn {
            MainView()
        }
        else {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
    }
}
