//
//  OrderView.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 08/01/26.
//

import SwiftUI

struct OrderView: View {
    
    ///Responsible For Sharing Data Throughout the App.
    @EnvironmentObject var currentOrder: OrderModel
    
    var body: some View {
        NavigationStack {
            List {
                ///Current Order Items List Section
                Section {
                    ForEach(currentOrder.orderedItems, id: \.0.id) {orderItem in
                        let orderItemQty = currentOrder.orderedItems.first(where: {$0.0 == orderItem.0})?.1 ?? 0
                        
                        HStack {
                            Text(orderItem.0.name)
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("You Pay: $\(orderItem.0.price) x \(orderItemQty)")
                                
                                Stepper {
                                    Text("Qty: \(orderItemQty)")
                                } onIncrement: {
                                    currentOrder.addMenuItemToOrderList(item: orderItem.0)
                                } onDecrement: {
                                    currentOrder.removeMenuItemFromOrderList(item: orderItem.0)
                                }
                            }
                        }
                    }
                    .onDelete {orderItemOffset in
                        currentOrder.orderedItems.remove(atOffsets: orderItemOffset)
                    }
                }
                
                ///Final Price And Place Order Section
                Section {
                    NavigationLink("Place Order") {
                        CheckoutView()
                    }
                }
                .disabled(currentOrder.orderedItems.isEmpty)
            }
            .navigationTitle("Order")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    OrderView().environmentObject(OrderModel())
}
