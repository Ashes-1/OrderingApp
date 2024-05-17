//
//  Alert.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissBtn: Alert.Button
}

struct AlertContext {
    
    static let invalidForm = AlertItem(title: Text("Error!"),
                                   message: Text("Please complete all fields on the form."),
                                   dismissBtn: .default(Text("OK")))
    
    static let invalidEmail = AlertItem(title: Text("Error!"),
                                   message: Text("Invalid email format."),
                                   dismissBtn: .default(Text("OK")))
    
    static let successForm = AlertItem(title: Text("Success!"),
                                   message: Text("Your changes have been saved successfully."),
                                   dismissBtn: .default(Text("OK")))
    
    static let invalidData = AlertItem(title: Text("Error!"),
                                   message: Text("There was an error in retrieving your profile."),
                                   dismissBtn: .default(Text("OK")))
    
    //new
    static let invalidCredentials = AlertItem(title: Text("Error!"),
                                   message: Text("Invalid login credentials. Please try again."),
                                   dismissBtn: .default(Text("OK")))
    
    static let orderPlaced = AlertItem(title: Text("Success!"),
                                   message: Text("Your order has successfully been placed."),
                                   dismissBtn: .default(Text("OK")))
    
    static let paymentSuccess = AlertItem(title: Text("Success!"),
                                   message: Text("Your payment was successful and your order has been placed."),
                                   dismissBtn: .default(Text("OK")))
}
