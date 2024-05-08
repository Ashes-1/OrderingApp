//
//  CartView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        NavigationView {
            Text("Cart View")
                .navigationTitle("Cart  🛒")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
