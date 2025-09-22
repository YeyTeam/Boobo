//
//  FavoriteSheet.swift
//  Boobo
//
//  Created by Aditya Rizki on 18/09/25.
//

import SwiftUI

struct FavoriteSheet: View {
    @ObservedObject var viewModel:SoundViewModel
    @Binding var isFavoriteSheetOpen: Bool
    @Environment(\.modelContext) var context
    @State var showDeleteAlert: Bool = false
    @State var mixData : MixModel? = nil
    
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
                    ForEach(viewModel.mixList, id: \.self) { mix in
                        HStack {
                            HStack(spacing: 16) {
                                VStack {
                                    Image("Thumbnail")
                                        .foregroundStyle(.white)
                                }
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
                            .onTapGesture {
                                viewModel.loadMix(mixData : mix)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "trash.fill")
                                .foregroundStyle(.red)
                                .font(.title3)
                                .padding(.trailing, 10)
                                .onTapGesture {
                                    showDeleteAlert = true
                                    mixData = mix
                                    viewModel.currentMix = mix
                                }
                                
                        }
                    }
                }
                .padding(.vertical)
            }
          
            
            
            // Save button sticky di bawah
            PrimaryButton(text : "Save"){
                
            }
            .padding(.top, 20)
        }
        .padding(.top, 30)
        .padding(.horizontal, 32)
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
        .onAppear{
            viewModel.context = context
        }
        .alert(isPresented: $showDeleteAlert ) {
            Alert(
                title: Text("Delete mix ?"),
                primaryButton:
                        .default(Text("Yes")) {
                            if mixData != nil {
                                viewModel.deleteMixData(data: mixData!)
                            }
                            
                            viewModel.loadMixData(context: context)
                        },
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
}


#Preview {
    @Previewable @StateObject var viewModel = SoundViewModel()
    VStack{
        FavoriteSheet(viewModel : viewModel, isFavoriteSheetOpen: .constant(true))

    }
    .background(
        Image("BackgroundA")
    )
}
