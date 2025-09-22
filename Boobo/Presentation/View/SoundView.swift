//
//  SoundView.swift
//  Boobo
//
//  Created by Abdul Jabbar on 16/09/25.
//
import SwiftUI

struct SoundView: View {
    // Demo volumes (unused by the fixed faders, keeping for now)
    @State private var vThunder: Double = 0.75
    @State private var vWater:   Double = 0.55
    @State private var vBirds:   Double = 0.60

    @EnvironmentObject var routeManager: RouteManager

    @StateObject private var viewModel = SoundViewModel()

    @State private var selected: Set<String> = ["waterfall", "birds"]
    @State private var isFavoriteSheetOpen: Bool = false

    // Sheet state
    @State private var showingAddMix = false
    @State private var draftMixName = ""

    @State private var showingSetDurationSheet = false
    @StateObject private var durationManager: DurationManager = DurationManager()

    var body: some View {
        ZStack(alignment: .top) {
            Image("BackgroundA")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 5) {
                header
                sliders
                chipStrip
                menuRow
                controls
                startSessionBar
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity)
            .background(
                Image("BackgroundA")
                    .resizable()
                    .scaledToFill()
            )
            .ignoresSafeArea(.all)
            .frame(maxHeight: .infinity)
        }
        // Present sheet here (the parent view)
        .sheet(isPresented: $showingAddMix) {
            // TODO: Replace `[]` with the actual `[SoundModelBeta]` source when available.
            AddMixSheetView(name: $draftMixName, data: []) { name in
                viewModel.addMix(name: name)
                showingAddMix = false
            }
            .presentationDetents([.fraction(0.36)])
            .presentationCornerRadius(24)
            .presentationDragIndicator(.hidden)
        }
        .sheet(isPresented: $showingSetDurationSheet) {
            VStack {
                SetDurationSheet(
                    isFavoriteSheetOpen: $isFavoriteSheetOpen, isPresented: $showingSetDurationSheet,
                    initialDuration: durationManager.currentRemainingTime > 0
                        ? durationManager.currentRemainingTime
                        : TimeInterval(durationManager.durationMinutes * 60),
                    onSave: { selected in
                        durationManager.start(duration: selected)
                    },
                    onDismiss: {
                        // optional: reset or leave as-is
                        durationManager.reset()
                    }
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(hex: "3D6196"),
                        Color(hex: "5F7BA5"),
                        Color(hex: "12416D")
                    ], startPoint: .top, endPoint: .bottom
                )
            )
            .environmentObject(durationManager)
            .presentationDetents([.fraction(0.45)])
            .presentationCornerRadius(24)
            .presentationDragIndicator(.hidden)
        }}

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
            ForEach(0..<3, id: \.self) { index in
                if index < viewModel.sounds.count {
                    // ✅ Manual Binding into array element
                    VerticalFader(
                        value: Binding(
                            get: { viewModel.sounds[index].volume },
                            set: { newVal in
                                viewModel.updateVolume(index: index, volume: Float(newVal))
                            }
                        ),
                        symbol: viewModel.sounds[index].icon
                    )
                } else {
                    VerticalFader(value: .constant(0.5), symbol: "music.note")
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
                    ForEach(soundList, id: \.id) { sound in
                        Chip(sound: sound, selected: $selected, viewModel: viewModel)
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
        .padding(.horizontal, -20)
    }

    // MARK: - Playlist Favorite (≡)
    private var menuRow: some View {
        HStack {
            Spacer()
            MenuButton(isFavoriteSheetOpen: $isFavoriteSheetOpen)
        }
    }

    // MARK: - Controls (timer, big play, save-mix)
    private var controls: some View {
        HStack(spacing: 42) {
            ActionCircleButton(systemName: "timer") {
                showingSetDurationSheet = true
            }
            PlayButton(viewModel: viewModel)

            SaveMixButton {
                draftMixName = ""
                showingAddMix = true
            }
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
    @ObservedObject var viewModel: SoundViewModel
    @State var isOn: Bool = false

    var body: some View {
        Button {
            isOn = viewModel.addSound(sound)
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
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 54, height: 54)
                .overlay(Circle().stroke(.white.opacity(0.85), lineWidth: 3))
        }
        .buttonStyle(.plain)
    }
}

private struct SaveMixButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 54, height: 54)
                .overlay(Circle().stroke(.white.opacity(0.85), lineWidth: 3))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Save mix")
    }
}

private struct PlayButton: View {
    @ObservedObject var viewModel: SoundViewModel

    var body: some View {
        Button {
            viewModel.playSound()
        } label: {
            ZStack {
                Circle().stroke(.white.opacity(0.9), lineWidth: 5)
                    .frame(width: 96, height: 90)
                if viewModel.isPlaying {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                } else {
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
            if #available(iOS 26.0, *) {
                HStack {
                    Text("Start sleep session")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.98))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white.opacity(0.98))
                }
                .padding()
                .cornerRadius(14)
                .glassEffect(.regular.tint(.white.opacity(0.05)), in: .rect(cornerRadius: 14))
            } else {
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
        }
    }
}

#Preview { SoundView() }

// MARK: - Temporary shim to satisfy `addMix(name:)` until implemented in SoundViewModel
extension SoundViewModel {
    @MainActor
    func addMix(name: String) {
        // TODO: Replace with real implementation in SoundViewModel
        #if DEBUG
        print("[SoundViewModel] addMix(name:) called with: \(name)")
        #endif
    }
}

extension SoundViewModel {
    @MainActor
    func stop() {
        #if DEBUG
        print("[SoundViewModel] stop() called")
        #endif
        // TODO: Wire to real stop logic in your audio engine
        self.isPlaying = false
    }
}

// MARK: - Temporary shim to fix missing API
// This extension satisfies the call site in `PlayButton`.
// Replace with your real implementation or remove once
// `AudioPlayerManager` gains a matching API.
//extension AudioPlayerManager {
//    enum PlaybackError: Error { case assetNotFound }
//
//    /// Plays multiple bundled audio assets by name.
//    /// - Parameter sounds: Array of resource names (without extension).
//    /// - Throws: `PlaybackError` or underlying audio errors in your real impl.
//    func playSounds(sounds: [String]) throws {
//        // TODO: Wire up to your actual audio engine.
//        // This no-op implementation unblocks compilation.
//        #if DEBUG
//        print("[AudioPlayerManager] playSounds called with: \(sounds)")
//        #endif
//    }
//}








