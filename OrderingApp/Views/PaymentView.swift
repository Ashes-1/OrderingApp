//
//  PaymentView.swift
//  OrderingApp
//
//  Created by Salha Alghoraibi on 17/5/2024.
//

import Foundation
import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var cart: Cart // Access the cart object from environment
    @EnvironmentObject var ordersViewModel: OrdersViewModel // Access the ordersViewModel object from environment
    @EnvironmentObject var accountViewModel: AccountViewModel // Access the accountViewModel object from environment
    @Environment(\.presentationMode) var presentationMode // Environment value for presentation mode ************
    @State private var cardNumber = "" // Track the entered card number
    @State private var expiryDate = "" // Track the entered expiry date
    @State private var cvv = "" // Track the entered CVV
    @State private var alert: AlertItem? // Alert to display payment success or failure
    @State private var isCashPayment: Bool = false // Track if cash payment is selected

    var totalPrice: Double // Total price passed from CartView
    
    var body: some View {
        VStack {
            Form {
                // Payment Method Section
                Section(header: Text("Payment Method")) {
                    // Toggle for selecting Cash payment option
                    Toggle("Cash", isOn: $isCashPayment)
                        .toggleStyle(SwitchToggleStyle(tint: Color("brandColor")))
                }
                
                // Card Information Section (displayed if not cash payment)
                if !isCashPayment {
                    Section(header: Text("Card Information")) {
                        // Textfield for entering card number
                        TextField("Card Number", text: $cardNumber)
                            .keyboardType(.numberPad)
                        // Textfield for entering expiry date
                        TextField("Expiry Date (MM/YY)", text: $expiryDate)
                            .keyboardType(.numberPad)
                            .onChange(of: expiryDate) { date in
                                expiryDate = expiryDateFormat(date)
                            }
                        // Secure textfield for entering CVV
                        SecureField("CVV", text: $cvv)
                            .keyboardType(.numberPad)
                    }
                }
                
                // Pay Button
                Button(action: processPayment) {
                    // Button text displaying total amount to be paid, either in cash or using a card
                    let paymentAmount = totalPrice 
                    Text("Pay $\(paymentAmount, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background(Color("brandColor"))
                        .cornerRadius(16)
                        .padding(.vertical)
                }
            }
        }
        .navigationTitle("Payment") // Set navigation title
        .alert(item: $alert) { alert in // Display alert if payment is successful or failed
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissBtn)
        }
    }
    
    // Process Payment function
    private func processPayment() {
        // For simplicity, assume payment is always successful
        let order = Order(items: cart.items, date: Date(), totalPrice: totalPrice)
        ordersViewModel.addOrder(order)
        cart.placeOrder()
        alert = AlertContext.paymentSuccess // Set payment success alert
        // Close the payment view
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    presentationMode.wrappedValue.dismiss()
        } //dismiss the sheet automatically after 0.5s
    }
    
    func expiryDateFormat(_ input: String) -> String {
        let filter = input.filter {
            "0123456789/".contains($0)
        }
        let userInput = filter.filter {
            "0123456789".contains($0)
        }
            
        if (userInput.count > 2) {
            let index = userInput.index(userInput.startIndex, offsetBy: 2)
            let month = userInput[..<index]
            let year = userInput[index...]
            return "\(month)/\(year)"
        }
        else {
            return userInput
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(totalPrice: 0.0)
            .environmentObject(Cart())
            .environmentObject(OrdersViewModel())
            .environmentObject(AccountViewModel(ordersViewModel: OrdersViewModel()))
    }
}
