//
//  MainView.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 08/01/26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "cart")
                }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(OrderModel())
}
