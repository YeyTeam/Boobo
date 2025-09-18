//
//  SoundView.swift
//  Boobo
//
//  Created by Abdul Jabbar on 16/09/25.
//
import SwiftUI

struct SoundView: View {
    // Fake volumes just for the visual slice
    @State private var vThunder: Double = 0.75
    @State private var vWater:   Double = 0.55
    @State private var vBirds:   Double = 0.60
    
    @EnvironmentObject var routeManager: RouteManager
    
    @StateObject var viewModel: SoundViewModel = SoundViewModel()
    // Selection state for chips (pure UI for now)
    @State private var selected: Set<String> = ["waterfall", "birds"]
    
    @State private var isFavoriteSheetOpen: Bool = false

    var body: some View {
            // Foreground content
            VStack(spacing: 5) {
                header
                sliders
                chipStrip
                menuRow
                controls
                startSessionBar
            }
            .padding(.horizontal, 20)
            .frame(maxHeight : .infinity)
            .background(
                Image("BackgroundA")
                    .resizable()
                    .scaledToFill()
            )
            .ignoresSafeArea(.all)
            .sheet(isPresented: $isFavoriteSheetOpen) {
                FavoriteSheet(isFavoriteSheetOpen: $isFavoriteSheetOpen)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.thinMaterial)
            }
    }

    // MARK: - Header
    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Better Sleep with White Sounds")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
                    .lineSpacing(2)

                Text("White sounds help you relax, drift off quickly, and enjoy uninterrupted sleep.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            HeartButton()
        }
    }

    // MARK: - Sliders
    private var sliders: some View {
        HStack(spacing: 44) {
            ForEach(0..<3) { value in
                if value < $viewModel.sounds.count {
                    VerticalFader(value: $viewModel.sounds[value].volume, symbol: viewModel.sounds[value].icon)
                        .onChange(of: viewModel.sounds[value].volume) { newValue,_ in
                            viewModel.updateVolume(index: value, volume: Float(newValue))
                        }
                }else{
                    VerticalFader(value: .constant(0.5), symbol: "plus.circle")
                    
                }
            }
            
            
        }
        .padding(.top, 6)
    }

    // MARK: - Sound Chip Strip
    private var chipStrip: some View {
        VStack(spacing: -2) {
            Divider().overlay(.white.opacity(0.15))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(soundList, id : \.self.id){ sound in
                        Chip(sound : sound, selected: $selected, viewModel: viewModel)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }
            Divider().overlay(.white.opacity(0.15))
        }
        .background(Color.black.opacity(0.18))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.top, 6)
        // override parent’s .padding(.horizontal, 20)
        .padding(.horizontal, -20)
    }

    // MARK: - Playlist Favorite (≡)
    private var menuRow: some View {
        HStack {
            Spacer()
            MenuButton(isFavoriteSheetOpen: $isFavoriteSheetOpen)
        }
    }

    // MARK: - Controls (timer, big play, plus)
    private var controls: some View {
        HStack(spacing: 42) {
            ActionCircleButton(systemName: "timer")
            PlayButton(viewModel: viewModel)
            ActionCircleButton(systemName: "plus")
        }
        .padding(.top, 4)
    }

    // MARK: - Start session bar
    private var startSessionBar: some View {
        StartSessionBar()
            .padding(.top, 20)
    }
}

// ==========================================================
// Components
// ==========================================================

private struct HeartButton: View {
    var body: some View {
        Button {} label: {
            ZStack {
                Circle()
                    .stroke(.white.opacity(0.7), lineWidth: 3)
                    .frame(width: 48, height: 48)
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct Chip: View {
    var sound: SoundModel
    
    @Binding var selected: Set<String>
    @StateObject var viewModel : SoundViewModel

    @State var isOn: Bool = false

    var body: some View {
        Button {
            isOn = viewModel.addSound(sound)
            //if isOn { selected.remove(key) } else { selected.insert(key) }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: sound.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isOn ? .black : .white)
                    .frame(width: 50, height: 50)
                    .background(Circle().fill(isOn
                        ? Color(red: 0.92, green: 0.80, blue: 0.50)
                        : .white.opacity(0.16)))
                Text(sound.name)
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .frame(width: 84)
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 0)
    }
}

private struct MenuButton: View {
    @Binding var isFavoriteSheetOpen: Bool
    
    var body: some View {
        Button {
            isFavoriteSheetOpen.toggle()
        } label: {
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(.white.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .buttonStyle(.plain)
    }
}

private struct ActionCircleButton: View {
    let systemName: String
    var body: some View {
        Button {} label: {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 54, height: 54)
                .overlay(Circle().stroke(.white.opacity(0.85), lineWidth: 3))
        }
        .buttonStyle(.plain)
    }
}

private struct PlayButton: View {
    @StateObject var viewModel:SoundViewModel

    var body: some View {
        Button {
            viewModel.playSound()
            
        } label: {
            ZStack {
                Circle().stroke(.white.opacity(0.9), lineWidth: 5)
                    .frame(width: 96, height: 90)
                if viewModel.isPlaying{
                    Image(systemName: "pause.fill")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                }else {
                    Image(systemName: "play.fill")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                }
                
            }
        }
        .buttonStyle(.plain)
    }
}

private struct StartSessionBar: View {
    @EnvironmentObject var routeManager: RouteManager
    
    var body: some View {
        Button {
            routeManager.navigate(to: .sleepTime)
        } label: {
            HStack {
                Text("Start sleep session")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.98))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.98))
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.white.opacity(0.18), Color.blue.opacity(0.28)],
                    startPoint: .leading, endPoint: .trailing
                )
            )
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(.white.opacity(0.25)))
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SoundView()
}
