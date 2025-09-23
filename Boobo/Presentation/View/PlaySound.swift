//
//  PlaySound.swift
//  Boobo
//
//  Created by Davian on 18/09/25.
//

import SwiftUI

struct PlaySound: View {
    @Environment(\.dismiss) var dismiss   // untuk close / kembali
    @State private var isPlaying = false  // state tombol play
    @State private var showOverlay = false // state overlay
    @StateObject var playSoundVM = PlaySoundViewModel()
    
    @EnvironmentObject var audioPlayerManager : AudioPlayerManager
    @EnvironmentObject var motionManager : MotionManager
    @State var showAlert : Bool = false
    @Environment(\.modelContext) var context
    
    var body: some View {
        ZStack {
            // Background
            Image("BackgroundA")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                // Title and Close button
                ZStack(alignment: .topTrailing) {
                    HStack {
                        Spacer()
                        Text("White Sound")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 78)
                    
                    Button(action: {
                        showAlert.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(8)
                            .padding(.horizontal)
                            .padding(.top, 78)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("End Session"),
                            message : Text("Are you sure want to end sleep session ?"),
                            primaryButton:
                                    .default(Text("Yes")){
                                        playSoundVM.audioPlayerManager.stopAll()
                                        dismiss() // kembali ke halaman sebelumnya (Home)

                                    },
                            secondaryButton:
                                    .cancel()
                        )

                    }
                }
                
                
                Spacer()
                
                // Sound Card
                VStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue.opacity(0.6))
                            .frame(width: 230, height: 230)
                        
                        // 3 icon overlapped
                        ZStack {
                            // Kiri
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 90, height: 90)
                                
                                Image(systemName: "waveform")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white.opacity(0.4))
                            }
                            .offset(x: -50)
                            
                            // Tengah
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "cloud.rain.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                            }
                            
                            // Kanan
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 90, height: 90)
                                
                                Image(systemName: "wind")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white.opacity(0.4))
                            }
                            .offset(x: 50)
                        }
                    }
                    
                    Text("\(playSoundVM.currentMix.mixName)")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    HStack(spacing : 0){
                        var count = 1
                        ForEach(playSoundVM.currentMix.mixSounds, id: \.self.id) { sound in
                            Text("\(sound.name) \( ( count < (playSoundVM.currentMix.mixSounds.count - 1) ) ? ", " : "" )")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                                .onAppear {
                                    count += 1
                                }
                            
                        }
                    }
                   
                }
                
                Spacer()
                
                // Play Button
                Button(action: {
                    if !isPlaying {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isPlaying = true
                            showOverlay = true
                            playSoundVM.playSound()
                        }
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(isPlaying ? Color.gray : Color.yellow)
                            .frame(width: 72, height: 72)
                        
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
                .disabled(isPlaying) // disable setelah jadi pause
                
                Spacer()
            }
            
            // Overlay muncul setelah play ditekan
            if showOverlay {
                ZStack {
                    Color.black.opacity(0.7).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Image("flip phone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.white)
                        
                        Text("Place your phone face down after pressing play")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .onTapGesture {
                    withAnimation(.easeOut) {
                        showOverlay = false
                    }
                }
                .transition(.opacity)
                .onChange(of: motionManager.isFaceDown){ isFaceDown,_ in
                    print("Omaigot you are face down: \(isFaceDown)")
                    if !isFaceDown && isPlaying {
                        playSoundVM.playSound()
                        
                    }else {
                        playSoundVM.stopSound()
                    }
                }
                
            }
                
        }
        .onAppear(){
            playSoundVM.audioPlayerManager = audioPlayerManager
            playSoundVM.loadMix(context: context)
            motionManager.start()
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @Previewable var audioPlayerManager = AudioPlayerManager()
    @Previewable var motionManager = MotionManager()

    PlaySound()
        .environmentObject(audioPlayerManager)
        .environmentObject(motionManager)
     
}
