//
//  OrderMenuModel.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 07/01/26.
//

import Foundation
import SwiftUI

struct MenuSection: Codable, Identifiable {
    var id: UUID
    var name: String
    var items: [OrderMenuItem]
}

struct OrderMenuItem: Codable, Hashable, Identifiable {
    var id: UUID
    var name, photoCredit: String
    var price: Int
    var restrictions: [String]
    var description: String
    
    var mainImage: String {
        name.replacingOccurrences(of: " ", with: "-").lowercased()
    }
    
    var thumbnailImage: String {
        mainImage.appending("-thumb")
    }
    
    #if DEBUG
    static let sampleMenuItem = OrderMenuItem(id: UUID(), name: "Maple French Toast", photoCredit: "Joseph Gonzalez", price: 6, restrictions: ["G", "V"], description: "Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…")
    #endif
}
