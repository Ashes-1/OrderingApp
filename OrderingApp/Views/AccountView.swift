//
//  AccountView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
    @State private var editMode = false
    
    var body: some View {
        NavigationView {
            VStack {
                if editMode {
                    Form {
                        Section(header: Text("My Details")) {
                            TextField("First Name", text: $viewModel.user.firstName)
                            TextField("Last Name", text: $viewModel.user.lastName)
                            TextField("Email", text: $viewModel.user.email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            SecureField("Password", text: $viewModel.user.password)
                                .keyboardType(.emailAddress)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            DatePicker("Date of Birth", selection: $viewModel.user.birthDate, displayedComponents: .date)
                        }
                        Button {
                            viewModel.saveChanges()
                        } label: {
                            Text("Save Changes")
                        }
                    }
                }
                else {
                    Form {
                        Section(header: Text("My Details")) {
                            HStack {
                                Text("First Name:")
                                Spacer()
                                Text(viewModel.user.firstName)
                            }
                            HStack {
                                Text("Last Name:")
                                Spacer()
                                Text(viewModel.user.lastName)
                            }
                            HStack {
                                Text("Email:")
                                Spacer()
                                Text(viewModel.user.email)
                            }
                            HStack {
                                Text("Password:")
                                Spacer()
                                Text(String(repeating: "*", count: viewModel.user.password.count))
                            }
                            HStack {
                                Text("Date of Birth:")
                                Spacer()
                                Text(viewModel.user.birthDate, formatter: Self.dateFormatter)
                            }
                        }
                        Section {
                            Button {
                                editMode = true
                            } label: {
                                Text("Edit Details")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Account")
        }
        .onAppear() {
            viewModel.retrieveUser()
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissBtn)
        }
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
