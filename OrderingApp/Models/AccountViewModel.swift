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
    @AppStorage("user") private var userData: Data?
    @Published var isLoggedIn = false //new
 
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
    
    func retrieveUser() {
        guard let userData = userData else { return }
        //decode
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
        }
        catch {
            alert = AlertContext.invalidData
        }
    }
    
    //new
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
    
    //new
    func logout() {
        isLoggedIn = false
    }
}


