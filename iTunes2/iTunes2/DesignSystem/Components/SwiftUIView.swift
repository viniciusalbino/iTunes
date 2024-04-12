//
//  SwiftUIView.swift
//  iTunes2
//
//  Created by Vinicius Albino on 16/10/23.
//

import SwiftUI

struct ItemCellView: View {
    var item: Item
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.title)
                    .bold()
                
                HStack {
                    Spacer()
                    
                    Text("R$")
                        .font(.headline)
                    
                    Text("\(item.value, specifier: "%.2f")")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }

                HStack {
                    Spacer()
                    
                    Text("Saiba mais")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "arrowtriangle.down")
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}


struct ItemListView: View {
    var items: [Item]
    
    var body: some View {
        NavigationView {
            List(items) { item in
                ItemCellView(item: item)
            }
            .navigationBarTitle("Items", displayMode: .inline)
        }
    }
}

#Preview {
    ItemListView(items: [Item.example])
}

struct Item: Identifiable {
    let id: Int
    let isActive: Int
    let order: Int
    let name: String
    let dependentCountMajor: Int
    let dependentCountMinor: Int
    let value: Double
    let registrationDate: Date
}


extension Item {
    static var example: Item {
        return Item(id: 1, isActive: 1, order: 1, name: "Plano Gold", dependentCountMajor: 3, dependentCountMinor: 2, value: 150.0, registrationDate: Date())
    }
}
