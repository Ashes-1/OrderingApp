//
//  LoginView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = AccountViewModel()
    @Binding var showRegistration: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "mug.fill")
                    .font(.system(size: 40))
                    .foregroundColor(Color("brandColor"))
                    .padding()
                TextField("Email", text: $viewModel.user.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Password", text: $viewModel.user.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                Button {
                    //perform action
                } label: {
                    Text("Login")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .background(Color("brandColor"))
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: RegisterView(), isActive: $showRegistration) {
                        Button("Register") {
                            showRegistration = true
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static private var showRegistration = false
    
    static var previews: some View {
        LoginView(showRegistration: $showRegistration)
    }
}
