//
//  AccountViewModel.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import Foundation
import SwiftUI

final class AccountViewModel: ObservableObject {
    @Published var user = User()
    @Published var alert: AlertItem?
    @AppStorage("user") private var userData: Data? //stores user data in UserDefaults
    @AppStorage("loggedIn") var isLoggedIn = false //stores if a user is logged in to UserDefaults
 
    //checks that form is filled in correctly
    var isValidForm: Bool {
        guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty else {
            alert = AlertContext.invalidForm
            return false
        }
        guard user.email.isValidEmail else {
            alert = AlertContext.invalidEmail
            return false
        }
        return true
    }
    
    //lets user update details
    func saveChanges() {
        guard isValidForm else { return }
        //encode user into data, and saving the data into user defaults
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            alert = AlertContext.successForm
        }
        catch {
            alert = AlertContext.invalidData
        }
    }
    
    //retrieves data for user
    func retrieveUser() {
        guard let userData = userData else {
            isLoggedIn = false
            return
        }
        //decode
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
            isLoggedIn = true
        }
        catch {
            alert = AlertContext.invalidData
        }
    }
    
    //checks credentials to be able to log in
    func login(email: String, password: String) {
        guard let userData = userData else {
            isLoggedIn = false
            alert = AlertContext.invalidCredentials
            return
        }
        do {
            let user = try JSONDecoder().decode(User.self, from: userData)
            if user.email == email && user.password == password {
                isLoggedIn = true
                self.user = user //set user property
            }
            else {
                isLoggedIn = false
                alert = AlertContext.invalidCredentials
            }
        }
        catch {
            isLoggedIn = false
            alert = AlertContext.invalidData
        }
    }
    
    func logout() {
        isLoggedIn = false
        user = User() //resets user object when user logs out
    }
}
