//
//  AccountViewModel.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import Foundation
import SwiftUI

final class AccountViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var birthDate = Date()
 
    var isValidForm: Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            print("Invalid email format.")
            return false
        }
        guard email.isValidEmail else {
            return false
        }
        return true
    }
    
    func saveChanges() {
        guard isValidForm else { return }
        print("Changes saved successfully!")
    }
}


