//
//  UserProfileView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 2/21/22.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        VStack{
            Text("User Profile View")
        }
        //.navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(AppViewModel())
    }
}
