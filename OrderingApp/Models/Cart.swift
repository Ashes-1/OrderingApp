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
    @Published var items: [Product] = []
    
    func add(_ product: Product) {
        items.append(product)
    }
    
    func delete(at offesets: IndexSet) {
        items.remove(atOffsets: offesets)
    }
}

////new
//struct CartItem: Identifiable {
//    let id = UUID()
//    let product: Product
//    let selectedSize: Option?
//    let selectedMilk: Option?
//    let selectedAddons: [Option]
//    
//    var totalPrice: Double {
//        let sizePrice = selectedSize?.price ?? 0
//        let milkPrice = selectedMilk?.price ?? 0
//        let addonsPrice = selectedAddons.reduce(0) { $0 + $1.price }
//        return sizePrice + milkPrice + addonsPrice
//    }
//}
