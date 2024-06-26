//
//  AccountView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel(ordersViewModel: OrdersViewModel())
    @State private var editMode = false
    @State private var showRegistration = false
    @State private var showAppTabView = false
        
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoggedIn { //only show user details if logged in
                    Form {
                        if editMode { //appears only if user edit details
                            Section(header: Text("My Details")) {
                                TextField("First Name", text: $viewModel.user.firstName)
                                TextField("Last Name", text: $viewModel.user.lastName)
                                TextField("Email", text: $viewModel.user.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                SecureField("Password", text: $viewModel.user.password)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                DatePicker("Date of Birth", selection: $viewModel.user.birthDate, displayedComponents: .date)
                            }
                            Button {
                                viewModel.saveChanges()
                                editMode = false
                            } label: {
                                Text("Save Changes")
                            }
                        }
                        else { //if not editing show details only
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
                            Section {
                                Button {
                                    viewModel.logout()
                                } label: {
                                    Text("Logout")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                else { //if user not logged in, show option to log in or register
                    VStack {
                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Color("brandColor"))
                            .padding()
                        Text("You are currently signed out.")
                            .padding(.bottom, 60)
                        NavigationLink(destination: LoginView(viewModel: viewModel, showRegistration: $showRegistration, showAppTabView: $showAppTabView)) {

                            Text("Login / Sign Up")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(width: 300, height: 50)
                                .foregroundColor(.white)
                                .background(Color("brandColor"))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Account")
        }
        .onAppear() { //if user is already logged in, account view would show details always
            if viewModel.isLoggedIn {
                viewModel.retrieveUser()
            }
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissBtn)
        }
        .fullScreenCover(isPresented: $showAppTabView, content: {
            AppTabView()
        })
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
