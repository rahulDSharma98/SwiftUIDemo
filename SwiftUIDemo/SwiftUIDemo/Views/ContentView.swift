//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 07/01/26.
//

import SwiftUI

struct ContentView: View {
    let menu: [MenuSection] = Bundle.main.decode([MenuSection].self, from: "OrderMenu.json")
    
    var body: some View {
        //NavigationController
        NavigationStack {
            //ViewController
            List {
                ForEach(menu) {menuSection in
                    Section(header: Text(menuSection.name)) {
                        ForEach(menuSection.items) {menuItem in
                            /*
                            ///Similar To Navigate Or Push VC Of UIKit
                            ///The Main Issue Here is that everytime a row is created, a NavigationLink with a destination to OrderMenuItemDetail will also be created which will be more memory consuming and inefficient way.
                            NavigationLink(destination: OrderMenuItemDetail(orderMenuItem: menuItem), label: {
                                ///Similar To UITableViewCell
                                OrderMenuItemRow(orderMenuItem: menuItem)
                            })
                            */
                            
                            NavigationLink(value: menuItem) {
                                OrderMenuItemRow(orderMenuItem: menuItem)
                            }
                        }
                    }
                    .headerProminence(.increased)
                }
            }
            .navigationTitle("Menu")
            .navigationDestination(for: OrderMenuItem.self) {menuItem in
                OrderMenuItemDetail(orderMenuItem: menuItem)
            }
            .listStyle(.grouped)
        }
    }
    /*
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width / 4), maximum: (UIScreen.main.bounds.width / 2)), spacing: 0, alignment: .center),
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width / 4), maximum: (UIScreen.main.bounds.width / 2)), spacing: 0, alignment: .center),
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width / 4), maximum: (UIScreen.main.bounds.width / 2)), spacing: 0, alignment: .center)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                Spacer(minLength: 10)
                    .frame(height: 20)
                
                LazyVGrid(columns: columns, alignment: .center, pinnedViews: [.sectionHeaders]) {
                    ForEach(menu) {menuSection in
                        Section {
                            ForEach(menuSection.items) {menuItem in
                                NavigationLink(value: menuItem) {
                                    OrderMenuItemRow(orderMenuItem: menuItem)
                                        .padding(.horizontal, 10)
                                }
                            }
                        } header: {
                            HStack(alignment: .center) {
                                Text(menuSection.name)
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 15)
                        }
                        .headerProminence(.increased)
                    }
                }
            }
            .scrollIndicators(.never)
            .navigationTitle("Menu")
            .navigationDestination(for: OrderMenuItem.self) {menuItem in
                OrderMenuItemDetail(orderMenuItem: menuItem)
            }
        }
    }*/
}

#Preview {
    ContentView()
}
