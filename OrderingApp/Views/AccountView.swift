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
    @State private var showRegistration = false
    @State private var showAppTabView = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoggedIn {
                    Form {
                        if editMode {
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
                                editMode = false //new
                            } label: {
                                Text("Save Changes")
                            }
                        }
                        else {
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
                else {
                    VStack {
                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Color("brandColor"))
                            .padding()
                        Text("You are currently signed out.")
                            .padding(.bottom, 60)
                        NavigationLink(destination: LoginView(showRegistration: $showRegistration, showAppTabView: $showAppTabView)) {
                            Text("Login / Sign Up")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(width: 300, height: 50)
                                .foregroundColor(.white)
                                .background(Color("brandColor"))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        
//                        NavigationLink(destination: RegisterView()) {
//                            Text("Register")
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                                .frame(width: 300, height: 50)
//                                .foregroundColor(.white)
//                                .background(Color("brandColor"))
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding()
                    }
                }
            }
            .navigationTitle("Account")
        }
        .onAppear() {
            viewModel.retrieveUser()
        }
        //new
        .onChange(of: viewModel.isLoggedIn) { userDeets in
            if userDeets {
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
    
//    var body: some View {
//        NavigationView {
//            VStack {
//                if viewModel.isLoggedIn {
//                    Form {
//                        Section(header: Text("My Details")) {
//                            HStack {
//                                Text("First Name:")
//                                Spacer()
//                                Text(viewModel.user.firstName)
//                            }
//                            HStack {
//                                Text("Last Name:")
//                                Spacer()
//                                Text(viewModel.user.lastName)
//                            }
//                            HStack {
//                                Text("Email:")
//                                Spacer()
//                                Text(viewModel.user.email)
//                            }
//                            HStack {
//                                Text("Password:")
//                                Spacer()
//                                Text(String(repeating: "*", count: viewModel.user.password.count))
//                            }
//                            HStack {
//                                Text("Date of Birth:")
//                                Spacer()
//                                Text(viewModel.user.birthDate, formatter: Self.dateFormatter)
//                            }
//                        }
//                        Section {
//                            Button {
//                                viewModel.logout()
//                            } label: {
//                                Text("Logout")
//                                    .foregroundColor(.red)
//                            }
//                        }
//                    }
//                }
//                else {
//                    VStack {
//                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
//                            .font(.system(size: 60))
//                            .foregroundColor(Color("brandColor"))
//                            .padding()
//                        Text("You are currently signed out.")
//                            .padding(.bottom, 60)
//                        NavigationLink(destination: LoginView(showRegistration: $showRegistration, showAppTabView: $showAppTabView)) {
//                            Text("Login / Sign Up")
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                                .frame(width: 300, height: 50)
//                                .foregroundColor(.white)
//                                .background(Color("brandColor"))
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding()
//                    }
//                }
//            }
//            .navigationTitle("Account")
//        }
//        .onAppear {
//            viewModel.retrieveUser()
//        }
//        .onChange(of: viewModel.isLoggedIn) { userDeets in
//            if userDeets {
//                viewModel.retrieveUser()
//            }
//        }
//        .alert(item: $viewModel.alert) { alert in
//            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissBtn)
//        }
//        .fullScreenCover(isPresented: $showAppTabView, content: {
//            AppTabView()
//        })
//    }
    
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
