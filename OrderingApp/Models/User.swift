//
//  User.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import Foundation

struct User: Codable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var birthDate = Date()
    var orders: [Order] = []

}

