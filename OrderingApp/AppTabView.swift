//
//  ContentView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct AppTabView: View {
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .badge(cart.items.count)
            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "doc.text.fill")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
        .accentColor(Color("brandColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .environmentObject(Cart())
            .environmentObject(OrdersViewModel())
            .environmentObject(AccountViewModel())
    }
}
