//
//  OrderingAppApp.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

@main
struct OrderingAppApp: App {
    var cart = Cart() //new
    
    var body: some Scene {
        WindowGroup {
            LoadingView().environmentObject(cart) //new
        }
    }
}
