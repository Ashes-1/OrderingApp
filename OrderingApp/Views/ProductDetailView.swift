//
//  ProductDetailView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cart: Cart //new
    
    let product: Product
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            product.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 200)
            VStack {
                Text(product.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(product.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
            }
            
            Spacer()
            
            Button {
                cart.add(product) //new
                isPresented = false
            } label: {
                Text("total price")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width: 260, height: 50)
                    .foregroundColor(.white)
                    .background(Color("brandColor"))
            }
            .padding(.bottom, 30)
        }
//        .frame(width: 350, height: 600)
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(radius: 100)
//        .overlay(Button {
//            print("Dismiss")
//        } label: {
//            ZStack {
//                Circle()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.white)
//                Image(systemName: "xmark")
//                    .frame(width: 50, height: 50)
//                    .imageScale(.large)
//                    .foregroundColor(Color("brandColor"))
//            }
//        }, alignment: .topTrailing)
        .overlay(Button(action: {
            isPresented = false // Close the sheet
        }) {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                Image(systemName: "xmark")
                    .frame(width: 50, height: 50)
                    .imageScale(.large)
                    .foregroundColor(Color("brandColor"))
            }
        }, alignment: .topTrailing)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    @State static var isPresented = false
    static var previews: some View {
        let sampleJSON = """
        {
            "id": "01",
            "name": "Sample Product",
            "category": "Hot",
            "description": "This is a sample product.",
            "size": [
                {
                    "name": "Small",
                    "price": 2.99
                },
                {
                    "name": "Medium",
                    "price": 3.99
                },
                {
                    "name": "Large",
                    "price": 4.99
                }
            ],
            "milk": [
                {
                    "name": "Whole Milk",
                    "price": 0.0
                },
                {
                    "name": "Almond Milk",
                    "price": 0.5
                }
            ],
            "addons": [
                {
                    "name": "Sugar",
                    "price": 0.0
                },
                {
                    "name": "Vanilla Syrup",
                    "price": 0.5
                }
            ],
            "imageName": "sampleImage"
        }
        """
        
        let decoder = JSONDecoder()
        if let sampleProduct = try? decoder.decode(Product.self, from: Data(sampleJSON.utf8)) {
            ProductDetailView(product: sampleProduct, isPresented: $isPresented)
                .environmentObject(Cart())
        }
    }
}

//struct ProductDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleJSON = """
//        """
//        let decoder = JSONDecoder()
//        if let sampleProduct = try? decoder.decode(Product.self, from: Data(sampleJSON.utf8)) {
//            ProductDetailView(product: sampleProduct)
//        }
//    }
//}
