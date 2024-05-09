//
//  ContentView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
            OrdersView()
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("Orders")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
        .accentColor(Color("brandColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .environmentObject(Cart())
    }
}
