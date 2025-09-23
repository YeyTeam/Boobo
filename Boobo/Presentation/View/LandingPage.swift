//
//  LancingPage.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 23/09/25.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        ZStack{
            Image("AppLogo")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("Background0")
        )
    }
}

#Preview {
    LandingPage()
}
