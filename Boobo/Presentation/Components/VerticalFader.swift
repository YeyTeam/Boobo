//
//  VerticalFader.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 17/09/25.
//
import SwiftUI

struct VerticalFader: View {
    @Binding var value: Double // 0...1
    let symbol: String

    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height

            ZStack(alignment: .bottom) {
                // Track
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.black.opacity(0.28))
                    .frame(width: 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.white.opacity(0.12), lineWidth: 1)
                    )

                // Fill
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 20)
                    .frame(height: height * value)

                // Knob
                Image(systemName: symbol)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(width: 56, height: 56)
                    .background(Circle().fill(Color(red: 0.92, green: 0.80, blue: 0.50)))
                    .overlay(Circle().stroke(.white.opacity(0.25), lineWidth: 10))
                    .shadow(color: .black.opacity(0.25), radius: 6, y: 2)
                    .offset(y: -(height - 56) * value)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { g in
                        // Clamp value between 0 and 1
                        let clamped = max(0, min(height, height - g.location.y))
                        value = clamped / height
                    }
            )
        }
        .frame(width: 70, height: 210)
        .padding(.vertical, 10)
    }
}
