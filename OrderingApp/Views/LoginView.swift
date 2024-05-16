//
//  LoginView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: AccountViewModel
       @Binding var showRegistration: Bool
       @Binding var showAppTabView: Bool
       @EnvironmentObject var ordersViewModel: OrdersViewModel



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
                    //allows user to login with correct credentials and shows AppTabView
                    viewModel.login(email: viewModel.user.email, password: viewModel.user.password)
                    if viewModel.isLoggedIn {
                        showAppTabView = true
                    }
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
                    Button("Register") {
                        showRegistration = true
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showRegistration) { // Shows registration screen
                           RegisterView(viewModel: AccountViewModel(ordersViewModel: OrdersViewModel()))
                       }
            .alert(item: $viewModel.alert) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissBtn)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static private var showRegistration = false
    @State static private var showAppTabView = false
    
    static var previews: some View {
        LoginView(viewModel: AccountViewModel(ordersViewModel: OrdersViewModel()), showRegistration: $showRegistration, showAppTabView: $showAppTabView)
    }
}
