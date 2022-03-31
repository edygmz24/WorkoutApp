//
//  SignUpView.swift
//  WorkoutApp
//
//  Created by Edy Gomez on 2/20/22.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var viewModel : AppViewModel
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var fullName = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Image("appLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack{
                    TextField("Full Name", text: $fullName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !fullName.isEmpty, password == confirmPassword else {
                            return
                        }
                        Task {
                            await viewModel.signUp(email: email, password: password, fullName: fullName)
                        }
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                    }).padding()
                }
                
                Spacer()
            }
            .padding()
        } .navigationBarTitle("Create Account", displayMode: .inline)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AppViewModel())
    }
}
