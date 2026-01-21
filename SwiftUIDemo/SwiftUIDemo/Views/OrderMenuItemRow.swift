//
//  OrderMenuItemRow.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 08/01/26.
//

import SwiftUI

struct OrderMenuItemRow: View {
    var orderMenuItem: OrderMenuItem
    
    let restrictionsColors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    
    var body: some View {
        HStack {
            Image(orderMenuItem.thumbnailImage)
                .resizable()
                .frame(minWidth: (UIScreen.main.bounds.width / 15), idealWidth: (UIScreen.main.bounds.width / 9), maxWidth: (UIScreen.main.bounds.width / 5), minHeight: (UIScreen.main.bounds.width / 15), idealHeight: (UIScreen.main.bounds.width / 9), maxHeight: (UIScreen.main.bounds.width / 5))
                .clipShape(.circle)
                .overlay(Circle().stroke(.gray, lineWidth: 2.0))
            /*
            AsyncImage(url: URL(string: "https://tmpfiles.org/dl/19620091/maple-french-toast2x.jpg")) {
                $0.resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)
                    .overlay(Circle().stroke(.gray, lineWidth: 2.0))
            } placeholder: {
                Color(uiColor: .red)
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)
                    .overlay(Circle().stroke(.gray, lineWidth: 2.0))
            }
            */
            
            Spacer(minLength: 5).frame(width: 10)
            
            VStack(alignment: .leading) {
                Text(orderMenuItem.name)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(orderMenuItem.description)
                    .lineLimit(2, reservesSpace: false)
                    .font(.caption)
                    .fontWeight(.regular)
                
                Spacer(minLength: 5).frame(height: 10)
                
                HStack(alignment: .center) {
                    ForEach(orderMenuItem.restrictions, id: \.self) {restriction in
                        Text(restriction)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(5)
                            .foregroundStyle(.white)
                            .background(restrictionsColors[restriction, default: .black])
                            .clipShape(.circle)
                    }
                }
                
                Text("Price: $\(orderMenuItem.price)")
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    OrderMenuItemRow(orderMenuItem: .sampleMenuItem)
}
