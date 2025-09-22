//
//  BedtimeView.swift
//  Boobo
//
//  Created by Aditya Rizki on 15/09/25.
//

//
//  BedtimeView.swift
//  Boobo
import SwiftUI

struct BedtimeView: View {
    @State private var isOn = false
    @State private var isWakeUpTimeSheetPresented = false   // one consistent name

    // Wake time the user sets
    @State private var wakeHour: Int = 6
    @State private var wakeMinute: Int = 0

    // Derived bedtime = wake - 8h
    private var sleepTime: (h: Int, m: Int) {
        let total = wakeHour * 60 + wakeMinute
        let mins = (total - 8*60 + 24*60) % (24*60)
        return (mins / 60, mins % 60)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Bedtime Set Up")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Toggle("", isOn: $isOn)
                    .frame(width: 40, height: 40)
            }

            Text("Setting up your bedtime trains your body to feel sleepy at the right time. Set your wake-up time, and we’ll suggest the best bedtime so you can get 6 hours of sleep.")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.top, 8)

            Divider()
                .frame(height: 1)
                .background(.white.opacity(0.5))
                .padding(.vertical)

            // Sleep time row
            HStack {
                HStack {
                    Image(systemName: "bed.double.fill")
                        .foregroundColor(Color(hex: "FEBB2E"))
                        .font(.title)
                    Text("Sleep Time")
                        .foregroundColor(Color(hex: "FEBB2E"))
                        .font(.title.weight(.bold))
                }
                Spacer()
                Button {
                    isWakeUpTimeSheetPresented = true
                } label: {
                    Text("Change")
                        .font(.body)
                        .foregroundColor(.gray)
                        .underline(true, color: .gray)
                }
            }

            // Show derived bedtime
            Text("\(two(sleepTime.h)).\(two(sleepTime.m))")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top)

            Divider()
                .frame(height: 1)
                .background(.white.opacity(0.5))
                .padding(.vertical)

            Text("Sleep Hygiene")
                .foregroundColor(Color(hex: "FEBB2E"))
                .font(.title.weight(.bold))

            Text("Sleep hygiene is about creating healthy habits that prepare your body for rest.")
                .foregroundStyle(.white)
                .padding(.top, 12)

            VStack(alignment: .leading) {
                HStack { Image(systemName: "lamp.floor"); Text("Turn off the bright lights") }
                    .padding(.horizontal)
                    .foregroundColor(.white)

                Divider().frame(height: 1).background(.white.opacity(0.5))

                HStack { Image(systemName: "speaker.slash"); Text("Keep the room quiet to make it easier to fall asleep") }
                    .padding(.horizontal)
                    .foregroundColor(.white)

                Divider().frame(height: 1).background(.white.opacity(0.5))

                HStack { Image(systemName: "thermometer.variable"); Text("Adjust Room Temperature") }
                    .padding(.horizontal)
                    .foregroundColor(.white)

                Divider().frame(height: 1).background(.white.opacity(0.5))

                HStack { Image(systemName: "laptopcomputer.slash"); Text("Avoid Blue Light") }
                    .padding(.horizontal)
                    .foregroundColor(.white)
            }
            .padding(.vertical)
            .background(Color.black.opacity(0.2))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
            .cornerRadius(12)
            .padding(.top, 28)

            Spacer()
        }
        .padding(.top, 70)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("progress-bg")
                .resizable()
                .scaledToFill()
        )
        .ignoresSafeArea()
        // PRESENT THE SHEET
        .sheet(isPresented: $isWakeUpTimeSheetPresented) {
            WakeTimeSheetView(
                wakeHour: $wakeHour,
                wakeMinute: $wakeMinute
            ) { newWakeH, newWakeM, _, _ in
                // Update local state from sheet (sleep time auto-derives)
                wakeHour = newWakeH
                wakeMinute = newWakeM
            }
            .presentationDetents([.fraction(0.5), .medium, .large])
            .presentationCornerRadius(24)
            .presentationDragIndicator(.visible)
        }
    }

    private func two(_ n: Int) -> String { String(format: "%02d", n) }
}

#Preview { BedtimeView() }
