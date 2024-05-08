//
//  RegisterView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $viewModel.firstName)
                    .padding()
                TextField("Last Name", text: $viewModel.lastName)
                    .padding()
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding()
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                DatePicker("Date of Birth", selection: $viewModel.birthDate, displayedComponents: .date)
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
        }
    }
}

#Preview {
    RegisterView()
}
