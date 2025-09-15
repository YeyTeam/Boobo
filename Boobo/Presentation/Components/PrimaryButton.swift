//
//  PrimaryButton.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//
import SwiftUI

struct PrimaryButton: View {
    var text: String!
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .padding(.vertical , 10)
                .padding(.horizontal , 20)
                .font(.title2)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.buttonPrimary)
                )
            
        }
    }
}

#Preview {
    VStack{
        PrimaryButton(text : "Primary Button"){
            
        }

    }
    .background(
        Image("BackgroundA"))
}
