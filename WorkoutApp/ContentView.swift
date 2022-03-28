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
                Spacer()
                NavigationLink("Continue", destination: InitialView())
            }
            
        }.onAppear {
            viewModel.signedIn = viewModel.isSignedIn
            if viewModel.signedIn {
                Task {
                    await viewModel.getUserType()
                }
            }
            print("Contetn View user type: " + viewModel.userType )
        }
    }
}

struct InitialView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View{
        NavigationView {
            if viewModel.signedIn {
                MainView()
            }
            else {
                SignInView()
            }
        }.onAppear(){
            print("Initial View user type " + viewModel.userType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
    }
}
