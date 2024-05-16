//
//  RegisterView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct RegisterView: View {
   
    @StateObject var viewModel: AccountViewModel
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
                DatePicker("Date of Birth", selection: $viewModel.user.birthDate, in: ...Date.thirteenYearsAgo, displayedComponents: .date)
                    .padding()
                Button { //when button is tapped it will save user details in the Account model
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
            //x button closes view once tapped
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: AccountViewModel(ordersViewModel: OrdersViewModel()))
    }
}

// Adding minimum age of 13 year-old to register in the app 
extension Date {
    static var thirteenYearsAgo: Date {
        return Calendar.current.date(byAdding: .year, value: -13, to: Date())!
    }
}
