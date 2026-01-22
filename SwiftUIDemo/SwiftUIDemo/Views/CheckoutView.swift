//
//  CheckoutView.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 09/01/26.
//

import SwiftUI

struct CheckoutView: View {
    
    ///Responsible For Sharing Data Throughout the App.
    @EnvironmentObject var currentOrder: OrderModel
    
    ///Local Variable Used For Storing a Binding Value
    @State private var selectedPaymentMode: String = "Cash"
    @State private var isLoyaltyCardAvailable: Bool = false
    @State private var enteredCardNumber: String = ""
    @State private var selectedTipAmount: String = "$0"
    @State private var isCustomTipAmount: Bool = false
    @State private var customTipAmount: String = ""
    
    @State private var showOrderPlacedAlert: Bool = false
    
    let paymentModeOptions: [String] = ["Cash", "Credit Card", "Debit Card", "Net Banking", "UPI/QR"]
    
    let tipAmounts: [String] = ["$0", "$2", "$5", "$10", "Custom"]
    
    var totalCheckoutPrice: String {
        let orderTotal = currentOrder.totalAmount
        
        let tipAmountInInt = Int(Double($selectedTipAmount.wrappedValue.replacingOccurrences(of: "$", with: "")) ?? 0.0)
        
        let tip = ((selectedTipAmount == "Custom") ? Int(Double(customTipAmount) ?? 0.0) : tipAmountInInt)
        
        let grandTotal = orderTotal + tip
        
        return grandTotal.formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $selectedPaymentMode) {
                    ForEach(paymentModeOptions, id: \.self) {
                        Text($0)
                    }
                } label: {
                    Text("How do you want to pay?")
                }
                
                if !(["Cash", "Net Banking"].contains(selectedPaymentMode)) {
                    Toggle(isOn: $isLoyaltyCardAvailable.animation()) {
                        Text("Use Loyalty/Gift Card")
                    }
                }
                
                if isLoyaltyCardAvailable {
                    TextField(text: $enteredCardNumber) {
                        Text("Enter Loyalty/Gift Card Number")
                                .fontWeight(.light)
                    }
                    .keyboardType(.numberPad)
                }
            }
            
            Section("Select Tip Amount") {
                Picker("Tip Amount:", selection: $selectedTipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: selectedTipAmount) {newValue in
                    isCustomTipAmount = (newValue == "Custom")
                }
                .pickerStyle(.segmented)
                
                if isCustomTipAmount {
                    TextField(text: $customTipAmount) {
                        Text("Enter Custom Tip Amount")
                                .fontWeight(.light)
                    }
                    .keyboardType(.numberPad)
                }
            }
            
            Section("Order Total: \(totalCheckoutPrice)") {
                Button {
                    showOrderPlacedAlert.toggle()
                } label: {
                    Text("Confirm Order")
                        .fontWeight(.semibold)
                }

            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order Confirmed.", isPresented: $showOrderPlacedAlert) {
            //For Custom Alert Buttons
            /*
            Button {
                showOrderPlacedAlert.toggle()
            } label: {
                Text("Ok")
            }*/
        } message: {
            Text("Your Total Order Price was \(totalCheckoutPrice). Thank You!")
                .fontWeight(.medium)
        }
    }
}

#Preview {
    CheckoutView().environmentObject(OrderModel())
}
