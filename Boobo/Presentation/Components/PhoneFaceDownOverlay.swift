//
//  PhoneFaceDownOverlay.swift
//  Boobo
//
//  Created by Aditya Rizki on 21/09/25.
//

import SwiftUI

struct PhoneFaceDownOverlay: View {
    var body: some View {
        
        // Konten di tengah
        VStack(spacing: 20) {
            Image("phone-face-down")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            
            Text("Place your phone face down to play audio")
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(.black.opacity(0.8))
        .zIndex(999)
    }
}

#Preview {
    PhoneFaceDownOverlay()
}
