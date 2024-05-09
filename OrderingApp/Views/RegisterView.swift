//
//  RegisterView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = AccountViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $viewModel.user.firstName)
                    .padding()
                TextField("Last Name", text: $viewModel.user.lastName)
                    .padding()
                TextField("Email", text: $viewModel.user.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding()
                SecureField("Password", text: $viewModel.user.password)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                DatePicker("Date of Birth", selection: $viewModel.user.birthDate, displayedComponents: .date)
                    .padding()
                Button {
                    viewModel.saveChanges()
                } label: {
                    Text("Register")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .background(Color("brandColor"))
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
            .navigationTitle("Register")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 50, height: 50)
                    .imageScale(.large)
                    .foregroundColor(Color("brandColor"))
            }))
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissBtn)
        }
    }
}

#Preview {
    RegisterView()
}
