//
//  Product.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import Foundation
import SwiftUI

struct Product: Decodable, Identifiable {
    let id: String
    let name: String
    let category: String
    let description: String
    let size: [Option]
    let milk: [Option]
    let addons: [Option]
    private var imageName: String
    
    var image: Image {
        Image(imageName)
    }
}

struct Option: Decodable, Equatable {
    let name: String
    let price: Double
}
