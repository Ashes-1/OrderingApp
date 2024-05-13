//
//  ProductListCell.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct ProductListCell: View {
    let product: Product
    
    var body: some View {
        HStack {
            product.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            VStack {
                Text(product.name)
                    .font(.title2)
                    .fontWeight(.medium)
            }
        }
    }
}

struct ProductListCell_Previews: PreviewProvider {
    static var previews: some View {
        let sampleJSON = """
        """
        let decoder = JSONDecoder()
        if let sampleProduct = try? decoder.decode(Product.self, from: Data(sampleJSON.utf8)) {

            ProductListCell(product: sampleProduct)
        }
    }
}
