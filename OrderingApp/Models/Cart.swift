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
//    var totalPrice: Double {
//        items.reduce(0) { $0 + $1.price }
//    }
    
    func add(_ product: Product) {
        items.append(product)
    }
    
    func delete(at offesets: IndexSet) {
        items.remove(atOffsets: offesets)
    }
}
