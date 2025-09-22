//
//  FavoriteSheet.swift
//  Boobo
//
//  Created by Aditya Rizki on 18/09/25.
//

import SwiftUI

struct FavoriteSheet: View {
    @Binding var isFavoriteSheetOpen: Bool
    @State var mixList : [MixModel]
    
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
                    ForEach(mixList, id: \.self.id) { mix in
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
                                    Text("\(mix.mixName)")
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
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 90/255,  green: 134/255, blue: 179/255), location: 0.00),
                    .init(color: Color(red: 71/255,  green: 115/255, blue: 164/255), location: 0.35),
                    .init(color: Color(red: 45/255,  green:  94/255, blue: 142/255), location: 0.70),
                    .init(color: Color(red: 18/255,  green:  58/255, blue:  98/255), location: 1.00)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}


#Preview {
    VStack{
        FavoriteSheet(isFavoriteSheetOpen: .constant(true), mixList : [])

    }
    .background(
        Image("BackgroundA")
    )
}
