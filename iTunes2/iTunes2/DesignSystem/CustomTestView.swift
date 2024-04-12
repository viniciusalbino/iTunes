//
//  CustomTestView.swift
//  iTunes2
//
//  Created by Vinicius Albino on 17/10/23.
//

import SwiftUI

struct CustomLayoutView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Top bar with back button and title
            HStack {
                Button(action: {
                    // Handle back action
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                }
                
                Spacer()
                
                Text("Plano Gold")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Placeholder for alignment
                Image(systemName: "arrow.left")
                    .opacity(0)
                    .font(.title2)
            }
            .padding()
            
            // Image placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    Text("Image Placeholder")
                        .foregroundColor(.gray)
                )
                .padding(.horizontal)
            
            // Details Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Descrição")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris consequat.")
                    .font(.body)
                    .lineLimit(nil)
                
                Divider()
                
                Text("Regras de Uso")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris consequat.")
                    .font(.body)
                    .lineLimit(nil)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Bottom bar with price and button
            HStack(spacing: 16) {
                Text("R$ 150,00")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    // Handle buy action
                }) {
                    Text("Comprar")
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .background(.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLayoutView()
    }
}
