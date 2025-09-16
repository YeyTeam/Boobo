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

    // Selection state for chips (pure UI for now)
    @State private var selected: Set<String> = ["waterfall", "birds"]

    var body: some View {
        ZStack(alignment: .top) {
            // Background image behind everything
            Image("BackgroundA")
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
                startSessionBar
            }
            .padding(.horizontal, 20)
            .padding(.top, 50) // distance from top like the mock
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
            VerticalFader(value: $vThunder, symbol: "radiowaves.left")
            VerticalFader(value: $vWater,   symbol: "water.waves")
            VerticalFader(value: $vBirds,   symbol: "bird.fill")
        }
        .padding(.top, 6)
    }

    // MARK: - Sound Chip Strip
    private var chipStrip: some View {
        VStack(spacing: -2) {
            Divider().overlay(.white.opacity(0.15))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    Chip(title: "Thunder Storm",  key: "thunder",   system: "cloud.bolt.rain.fill", selected: $selected)
                    Chip(title: "Waterfall",       key: "waterfall", system: "water.waves",          selected: $selected)
                    Chip(title: "Birds",           key: "birds",     system: "bird.fill",            selected: $selected)
                    Chip(title: "Wind",            key: "wind",      system: "wind",                 selected: $selected)
                    Chip(title: "Clock Ticking",   key: "clock",     system: "clock",                selected: $selected)
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
            MenuButton()
        }
    }

    // MARK: - Controls (timer, big play, plus)
    private var controls: some View {
        HStack(spacing: 42) {
            ActionCircleButton(systemName: "timer")
            PlayButton()
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

private struct VerticalFader: View {
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
        .frame(width: 70, height: 260)
    }
}

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
    let title: String
    let key: String
    let system: String
    @Binding var selected: Set<String>

    var isOn: Bool { selected.contains(key) }

    var body: some View {
        Button {
            if isOn { selected.remove(key) } else { selected.insert(key) }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: system)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isOn ? .black : .white)
                    .frame(width: 58, height: 58)
                    .background(Circle().fill(isOn
                        ? Color(red: 0.92, green: 0.80, blue: 0.50)
                        : .white.opacity(0.16)))
                Text(title)
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .frame(width: 84)
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 2)
    }
}

private struct MenuButton: View {
    var body: some View {
        Button {} label: {
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
    var body: some View {
        Button {} label: {
            ZStack {
                Circle().stroke(.white.opacity(0.9), lineWidth: 5)
                    .frame(width: 96, height: 96)
                Image(systemName: "play.fill")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct StartSessionBar: View {
    var body: some View {
        Button {} label: {
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
