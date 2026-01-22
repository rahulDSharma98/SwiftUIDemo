//
//  OrderMenuItemDetail.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 08/01/26.
//

import SwiftUI

struct OrderMenuItemDetail: View {
    var orderMenuItem: OrderMenuItem
    
    ///Responsible For Sharing Data Throughout the App.
    @EnvironmentObject var currentOrder: OrderModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                Image(orderMenuItem.mainImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Photo:- \(orderMenuItem.photoCredit)")
                    .font(.subheadline)
                    .padding(4)
                    .background(.black.gradient.opacity(0.7))
                    .foregroundStyle(.white)
                    .offset(x: -2, y: -2)
            }
            
            Spacer(minLength: 10).frame(height: 20)
            
            Text(orderMenuItem.description)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .navigationTitle(orderMenuItem.name)
        .navigationBarTitleDisplayMode(.inline)
        
        Spacer(minLength: 10).frame(height: 20)
        
        Button("Order This Item Now") {
            currentOrder.addMenuItemToOrderList(item: orderMenuItem)
        }
        .buttonStyle(.borderedProminent)
        
        /*
        VStack(alignment: .leading) {
            Button("Order This Item Now") {
                currentOrder.addMenuItemToOrderList(item: orderMenuItem)
            }
            .padding()
            .frame(maxWidth: .infinity)
//            .buttonStyle(.borderedProminent)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            
            Button("View Cart") {
                _ = NavigationLink {
                    OrderView()
                } label: {
                    Text("View Cart")
                }

            }
            .padding()
            .frame(maxWidth: .infinity)
//            .buttonStyle(.borderedProminent)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
        }
        .fixedSize(horizontal: true, vertical: false)
        */
        
        Spacer()
    }
}

#Preview {
    NavigationStack {
        OrderMenuItemDetail(orderMenuItem: .sampleMenuItem).environmentObject(OrderModel())
    }
}
