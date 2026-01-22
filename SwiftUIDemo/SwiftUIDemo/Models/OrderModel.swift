//
//  OrderModel.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 07/01/26.
//

import Foundation
import Combine

class OrderModel: ObservableObject {
    ///Responsible For Notifying The Changes To The Data Throughout the App.
    @Published var orderedItems: [(OrderMenuItem, Int)] = [(OrderMenuItem, Int)]()
    
    var totalAmount: Int {
        if orderedItems.count > 0 {
            return orderedItems.reduce(0, {$0 + ($1.0.price * $1.1)})
        } else {
            return 0
        }
    }
    
    func addMenuItemToOrderList(item: OrderMenuItem) {
        if orderedItems.contains(where: {$0.0 == item}),
           let orderItemIndex = orderedItems.firstIndex(where: {$0.0 == item}) {
            orderedItems[orderItemIndex].1 += 1
        } else {
            orderedItems.append((item, 1))
        }
    }
    
    func removeMenuItemFromOrderList(item: OrderMenuItem) {
        if let index = orderedItems.firstIndex(where: {$0.0 == item}) {
            let orderItem = orderedItems[index]
            
            if orderItem.1 > 1 {
                orderedItems[index].1 -= 1
            } else {
                orderedItems.remove(at: index)
            }
        }
    }
    
    func deleteMenuItemFromOrderList(item: OrderMenuItem) {
        if let index = orderedItems.firstIndex(where: {$0.0 == item}) {
            orderedItems.remove(at: index)
        }
    }
}
