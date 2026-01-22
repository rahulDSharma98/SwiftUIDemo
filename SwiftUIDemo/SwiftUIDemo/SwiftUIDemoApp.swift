//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 07/01/26.
//

import SwiftUI

@main
struct SwiftUIDemoApp: App {
    ///Responsible For Observing The Changes And Updating The UI Throughout the App.
    @StateObject var currentOrder: OrderModel = OrderModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(currentOrder)
        }
    }
}
