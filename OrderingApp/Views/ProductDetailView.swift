//
//  ProductDetailView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cart: Cart
    @Environment(\.presentationMode) var presentationMode //access presentation mode of view
    let product: Product
    
    let sizes: [Option]
    let milkOptions: [Option]
    let addons: [Option]
    //allows us to track the selected options that the user picked
    @State private var selectedSize: Option?
    @State private var selectedMilk: Option?
    @State private var selectedAddons: [Option] = []
    
    var totalPrice: Double {
        let sizePrice = selectedSize?.price ?? 0
        let milkPrice = selectedMilk?.price ?? 0
        let addonsPrice = selectedAddons.reduce(0) { $0 + $1.price } //accumulate addon pricing
        return sizePrice + milkPrice + addonsPrice
    }
    
    //can't add product unless you choose a size or milk type
    var buttonDisabled: Bool {
        selectedSize == nil || selectedMilk == nil
    }
    
    var body: some View {
        VStack {
            ScrollView {
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
                    
                    Section(header: Text("Size")
                        .underline()
                        .font(.headline)
                    ) {
                        ForEach(sizes, id: \.name) { size in
                            //each size option from the database will be iterated and shown
                            HStack {
                                Text(size.name)
                                Spacer()
                                Text("$\(size.price, specifier: "%.2f")")
                                
                                //when an option is selected, it shows a checkmark
                                if selectedSize == size {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture { //updates the selected size when tapped
                                selectedSize = size
                            }
                        }
                    }
                    
                    Section(header: Text("Milk")
                        .underline()
                        .font(.headline)
                    ) {
                        ForEach(milkOptions, id: \.name) { milk in
                            HStack {
                                Text(milk.name)
                                Spacer()
                                Text("$\(milk.price, specifier: "%.2f")")
                                    
                                if selectedMilk == milk {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedMilk = milk
                            }
                        }
                    }
                    
                    Section(header: Text("Addons")
                        .underline()
                        .font(.headline)
                    ) {
                        ForEach(addons, id: \.name) { addon in
                            HStack {
                                Text(addon.name)
                                Spacer()
                                Text("$\(addon.price, specifier: "%.2f")")
                                
                                if selectedAddons.contains(addon) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if selectedAddons.contains(addon) {
                                    selectedAddons.removeAll { $0 == addon }
                                }
                                else {
                                    selectedAddons.append(addon)
                                }
                            }
                        }
                        
                    }
                }
                .padding()
            }
            Spacer()
            
            //this button allows user to add it to cart as CartItem, and closes the details once tapped
            //size and milk must be chosen to be able to press the button
            Button {
                let item = CartItem(product: product, selectedSize: selectedSize!, selectedMilk: selectedMilk!, selectedAddons: selectedAddons)
                cart.add(item)
                presentationMode.wrappedValue.dismiss() //closes the sheet
            } label: {
                Text("$\(totalPrice, specifier: "%.2f") - Add to Cart")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width: 260, height: 50)
                    .foregroundColor(.white)
                    .background(buttonDisabled ? Color.gray : Color("brandColor"))
            }
            .padding(.bottom, 30)
            .disabled(buttonDisabled)
        }
        .overlay(Button(action: { //x button can close the view
            presentationMode.wrappedValue.dismiss()
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
            ProductDetailView(product: sampleProduct, sizes: sampleProduct.size, milkOptions: sampleProduct.milk, addons: sampleProduct.addons)
                .environmentObject(Cart())
        }
    }
}
