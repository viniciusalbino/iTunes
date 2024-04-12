//
//  PlaygroundFIle.swift
//  iTunes2
//
//  Created by Vinicius Albino on 30/10/23.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    
    var body: some View {
        ZStack {
            Color(hex: "2E309D")
                .ignoresSafeArea()
            
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding()
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Vinicius Albino")
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("CPF: 37523305890")
                        .foregroundColor(.white)
                    
                    Text("Endereço: Rua teste 124")
                        .foregroundColor(.white)
                }
            }
        }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
    }
}

import SwiftUI

struct Dependent: Identifiable {
    let id = UUID()
    let name: String
    let cpf: String
}

struct ListView: View {
    @State private var dependents: [Dependent] = [
        Dependent(name: "Vinicius Albino", cpf: "375.233.058-90"),
        Dependent(name: "Vinicius Albino", cpf: "375.233.058-90")]
    
    var body: some View {
        ZStack {
            Color(hex: "4245D4")
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 12) {
                HeaderView()
                    .padding(.top, 50)
                
                Spacer()
                
                Text("03 Dependetes restantes")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                
                List {
                    ForEach(dependents) { dependent in
                        DependentCard(dependent: dependent)
                            .listRowBackground(Color(hex: "4245D4"))
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color(hex: "4245D4"))
                
                // Add button
                Button("Adicionar") {
                    let newDependent = Dependent(name: "New Name", cpf: "12345678900")
                    dependents.append(newDependent)
                }
                .frame(width: 200)
                .padding()
                .background(Color(hex: "#FBD03A"))
                .foregroundColor(Color(hex: "#4245D4"))                 .cornerRadius(8)
                .padding(.bottom, 60)
                .frame(width: 200)
            }
            .edgesIgnoringSafeArea(.all)
        } //
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct DependentCard: View {
    var dependent: Dependent
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "4245D4"))
            
            VStack {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.leading)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(dependent.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("CPF: \(dependent.cpf)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Action for the button
                        print("daishdiau")
                    }) {
                        HStack(spacing: 8) { // Horizontal stack to combine image and text
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            
                            Text("Editar") // Custom title
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                    }
                }
                
                Spacer()
                
                Divider()
                    .background(Color.white)
            }
        }
        .frame(height: 70)
        .padding([.top, .bottom])
        .background(Color(hex: "4245D4"))
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
