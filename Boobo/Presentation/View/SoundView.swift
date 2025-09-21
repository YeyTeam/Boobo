//
//  SoundView.swift
//  Boobo
//
//  Created by Abdul Jabbar on 16/09/25.
//

import SwiftUI

struct SoundView: View {
    // Volumes (demo)
    @State private var vThunder: Double = 0.75
    @State private var vWater:   Double = 0.55
    @State private var vBirds:   Double = 0.60
    @EnvironmentObject var audioPlayerManager : AudioPlayerManager
    @EnvironmentObject var routeManager: RouteManager
    @EnvironmentObject var sessionManager: SessionManager
    
    @StateObject var viewModel: SoundViewModel = SoundViewModel()
    // Selection state for chips (pure UI for now)
    
    @State private var selected: Set<String> = ["waterfall", "birds"]
    
    @State private var isFavoriteSheetOpen: Bool = false
    
    // SHEET STATE (must be inside the view)
    @State private var showingAddMix = false
    @State private var draftMixName = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background behind everything
            Image("BackgroundA") // ensure the asset is named exactly like this
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Foreground content
            VStack(spacing: 5) {
                header
                sliders
                chipStrip
                menuRow
                controls
                if sessionManager.isSleepTime {
                    startSessionBar
                } else {
                    notifInformationBar
                }
                
            }
            .padding(.horizontal, 20)
            .frame(maxHeight : .infinity)
            .background(
                Image("BackgroundA")
                    .resizable()
                    .scaledToFill()
            )
            .ignoresSafeArea(.all)
            .frame(maxHeight: .infinity)
            
            // Overlay Face Down Phone
            if sessionManager.isOverlayShow {
                PhoneFaceDownOverlay()
                    .zIndex(999)
            }
        }
        // Present sheet here (the parent view)
        .sheet(isPresented: $showingAddMix) {
            AddMixSheetView(name: $draftMixName) { name in
                // TODO: save with SwiftData later if you want
                //                 saveMix(name)
                viewModel.addMixSound(name: name)
                showingAddMix = false
            }
            .presentationDetents([.fraction(0.36)])
            .presentationCornerRadius(24)
            .presentationDragIndicator(.hidden)
        }
        .onAppear(){
            viewModel.audioPlayerManager = audioPlayerManager

//            sessionManager.isSleepTime = false
//            print(sessionManager.isSleepTime)
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
        // let the strip extend to the edges despite parent padding
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
            ActionCircleButton(systemName: "timer")
            PlayButton(viewModel: viewModel)
            
            // NEW: SaveMixButton replaces the "+" circle
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
    
    // MARK: - Start session bar
    private var notifInformationBar: some View {
        NotifInformationBar()
            .padding(.top, 20)
    }
}

// ==========================================================
// Components
// ==========================================================


//
//<<<<<<< HEAD
//=======
//    var body: some View {
//        GeometryReader { geo in
//            let height = geo.size.height
//
//            ZStack(alignment: .bottom) {
//                // Track (thin)
//                RoundedRectangle(cornerRadius: 18)
//                    .fill(Color.black.opacity(0.28))
//                    .frame(width: 20)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 18)
//                            .stroke(.white.opacity(0.12), lineWidth: 1)
//                    )
//
//                // Fill
//                RoundedRectangle(cornerRadius: 18)
//                    .fill(Color.white.opacity(0.15))
//                    .frame(width: 20, height: height * value)
//
//                // Knob
//                Image(systemName: symbol)
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundStyle(.black)
//                    .frame(width: 56, height: 56)
//                    .background(Circle().fill(Color(red: 0.92, green: 0.80, blue: 0.50)))
//                    .overlay(Circle().stroke(.white.opacity(0.25), lineWidth: 2))
//                    .shadow(color: .black.opacity(0.25), radius: 6, y: 2)
//                    .offset(y: -(height - 56) * value)
//            }
//            .gesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { g in
//                        // Clamp value between 0 and 1
//                        let clamped = max(0, min(height, height - g.location.y))
//                        value = clamped / height
//                    }
//            )
//        }
//        .frame(width: 70, height: 210)
//        .padding(.vertical, 10)
//    }
//}
//>>>>>>> c57086e3a1327dc0a0fd844733fe3d761a4ba433

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

// keep the generic circle for "timer"
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
                .glassEffect(.regular.tint(.white.opacity(0.05)), in : .rect(cornerRadius: 14))
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


private struct NotifInformationBar: View {
    @EnvironmentObject var routeManager: RouteManager
    
    var body: some View {
        
        if #available(iOS 26.0, *) {
            HStack {
                if let savedSleepTime = UserDefaults.standard.object(forKey: "sleepTime") as? Date {
                    Text("We will send you notification on \(savedSleepTime.formatted(date: .omitted, time: .shortened))")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.98))
                } else {
                    Text("We will send you notification on weekend")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.98))
                }
                
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.98))
            }
            .padding()
            .cornerRadius(14)
            .glassEffect(.regular.tint(.white.opacity(0.05)), in : .rect(cornerRadius: 14))
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


#Preview {
    let router = RouteManager()
    let sessionManager = SessionManager()
    
    SoundView()
        .environmentObject(router)
        .environmentObject(sessionManager)
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
