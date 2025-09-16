//
//  ProgressView.swift
//  Boobo
//
//  Created by Aditya Rizki on 16/09/25.
//

import SwiftUI

struct StreakView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Sleep Progress")
                .font(.title.weight(.bold))
                .foregroundColor(.white)
            Text("Every 14 nights of sleeping on time becomes one streak. Don’t break the streak and let each streak bring you closer to better rest.")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.bottom, 48)
                .padding(.top, 8)
            HStack(alignment: .top) {
                VStack {
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.white)
                        Text("Total Streak")
                            .foregroundColor(.white)
                            .font(.caption.weight(.medium))
                    }
                    Text("15")
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.bold))
                }
                .padding(12)
                .background(.ultraThinMaterial.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Button(action: {}){
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .font(.title3.weight(.bold))
                }
            }
            .padding(.bottom)
            ForEach(1...2, id: \.self) { _ in
                HStack {
                    ForEach(1...7, id: \.self) { day in
                        VStack {
                            Text("Day \(day)")
                                .font(.caption2.weight(.bold))
                                .foregroundColor(.white)
                            VStack {
                                Image(systemName: "moon")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.yellow)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                .padding()
                .background(.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top, 12)
            }
            Spacer()
        }
        .padding(.top, 64)
        .padding(.horizontal, 13)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("progress-bg")
                .resizable()
                .scaledToFill()
        )
        .ignoresSafeArea()
    }
}

#Preview {
    StreakView()
}
