//
//  MainDashboardView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 2/21/22.
//

import SwiftUI

struct UserDashboardView: View {
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        VStack{
            HStack{
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
            }.padding()
            
            Spacer()
            VStack{
                Text("Main Dashboard View")
                    .padding()
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $viewModel.triggerSignInView){
            SignInView()
        }
    }
}

struct MainDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboardView().environmentObject(AppViewModel())
    }
}
