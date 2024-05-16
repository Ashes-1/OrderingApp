//
//  OrdersViewModel.swift
//  OrderingApp
//
//  Created by Rosa Long on 13/5/2024.
//
import Foundation
import SwiftUI

class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @AppStorage("loggedIn") var isLoggedIn = false
    @AppStorage("user") var userData: Data?

    func addOrder(_ order: Order) {
        orders.append(order)
        updateUserOrders()
    }

    func clearOrders() {
        orders.removeAll()
    }

    func loadUserOrders() {
        guard isLoggedIn, let userData = userData else { return }
        do {
            let user = try JSONDecoder().decode(User.self, from: userData)
            orders = user.orders
        } catch {
            print("Failed to load user orders: \(error)")
        }
    }

    private func updateUserOrders() {
        guard isLoggedIn, let userData = userData else { return }
        do {
            var user = try JSONDecoder().decode(User.self, from: userData)
            user.orders = orders
            let encodedData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(encodedData, forKey: "user")
        } catch {
            print("Failed to encode user data with orders: \(error)")
        }
    }
}

struct Order: Identifiable, Codable {
    var id = UUID()
    let items: [CartItem]
    var itemTotal: Int {
        items.count
    }
    let date: Date
    let totalPrice: Double

    init(items: [CartItem], date: Date, totalPrice: Double) {
        self.items = items
        self.date = date
        self.totalPrice = totalPrice.isNaN ? 0.0 : totalPrice // Ensure totalPrice is not NaN
    }
}

