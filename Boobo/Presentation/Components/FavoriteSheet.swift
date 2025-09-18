//
//  FavoriteSheet.swift
//  Boobo
//
//  Created by Aditya Rizki on 18/09/25.
//

import SwiftUI

struct FavoriteSheet: View {
    @Binding var isFavoriteSheetOpen: Bool
    
    var body: some View {
        VStack {
            // Header
            ZStack {
                Text("Favorite Playlist")
                    .font(.title2)
                    .foregroundStyle(.white)
                HStack {
                    Spacer()
                    Image(systemName: "x.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
            }
            .padding(.bottom, 16)
            .onTapGesture {
                isFavoriteSheetOpen = false
            }
            
            // Scrollable playlist
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10, id: \.self) { index in
                        HStack {
                            HStack(spacing: 16) {
                                VStack {
                                    Image(systemName: "play.fill")
                                        .foregroundStyle(.white)
                                }
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Soundku \(index + 1)")
                                        .font(.title3.weight(.medium))
                                        .foregroundStyle(.white)
                                    Text("3 sounds")
                                        .font(.footnote)
                                        .foregroundStyle(.white)
                                }
                            }
                            Spacer()
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.white)
                                .font(.title3)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            
            // Save button sticky di bawah
            Button(action: {
                print("Save tapped")
            }) {
                Text("Save")
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                Color(hex: "FFFFFF"),
                                Color(hex: "D7D7D7"),
                                Color(hex: "B7B7B7")
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
            .padding(.top, 16)
        }
        .padding(32)
    }
}
