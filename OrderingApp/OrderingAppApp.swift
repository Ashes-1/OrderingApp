//
//  OrderingAppApp.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

@main
struct OrderingAppApp: App {
    @StateObject var cart = Cart()
        @StateObject var ordersViewModel = OrdersViewModel()
        @StateObject var accountViewModel = AccountViewModel(ordersViewModel: OrdersViewModel())

    var body: some Scene {
        WindowGroup {
            LoadingView()
                .environmentObject(cart)
                .environmentObject(ordersViewModel)
                .environmentObject(accountViewModel)
                        }
    }
}
