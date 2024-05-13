//
//  OrderingAppApp.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

@main
struct OrderingAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            LoadingView()
                .environmentObject(Cart())
                .environmentObject(OrdersViewModel())
                .environmentObject(AccountViewModel())
        }
    }
}
