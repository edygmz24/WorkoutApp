//
//  TrainerView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 3/4/22.
//

import SwiftUI

struct TrainerView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        VStack{
            Spacer()
            
            Text("This is the Trainer View")
            
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
        
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView().environmentObject(AppViewModel())
    }
}
