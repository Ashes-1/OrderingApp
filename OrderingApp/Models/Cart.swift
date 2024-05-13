//
//  Cart.swift
//  OrderingApp
//
//  Created by Rosa Long on 10/5/2024.
//

import Foundation
import SwiftUI

//new
final class Cart: ObservableObject {
    @Published var items: [CartItem] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
    
    func add(_ item: CartItem) {
        items.append(item)
    }
    
    func delete(at offesets: IndexSet) {
        items.remove(atOffsets: offesets)
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    let selectedSize: Option
    let selectedMilk: Option
    let selectedAddons: [Option]
    
    var totalPrice: Double {
        let sizePrice = selectedSize.price
        let milkPrice = selectedMilk.price
        let addonsPrice = selectedAddons.reduce(0) { $0 + $1.price }
        return sizePrice + milkPrice + addonsPrice
    }
}
