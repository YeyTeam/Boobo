//  WakeTimeSheetView.swift
//  Boobo
//
//  Created by Abdul Jabbar on 18/09/25.


import SwiftUI

struct WakeTimeSheetView: View {
    @EnvironmentObject var routeManager: RouteManager
    @Binding var wakeHour: Int
    @Binding var wakeMinute: Int
    var onSave: (_ wakeHour: Int, _ wakeMinute: Int, _ sleepHour: Int, _ sleepMinute: Int) -> Void

    @Environment(\.dismiss) private var dismiss

    // Brand gold used across the app
    private let gold = Color(red: 0.98, green: 0.86, blue: 0.47)

    // Sleep = wake - 8h (wrap across midnight)
    private var sleepTime: (hour: Int, minute: Int) {
        let t = (wakeHour * 60 + wakeMinute - 8 * 60 + 24 * 60) % (24 * 60)
        return (t / 60, t % 60)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Background gradient (kept from your last version)
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 90/255,  green: 134/255, blue: 179/255), location: 0.00),
                    .init(color: Color(red: 71/255,  green: 115/255, blue: 164/255), location: 0.35),
                    .init(color: Color(red: 45/255,  green:  94/255, blue: 142/255), location: 0.70),
                    .init(color: Color(red: 18/255,  green:  58/255, blue:  98/255), location: 1.00)
                ]),
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

        
                VStack(spacing: 18) {
                    // Title row
                    HStack {
                        Spacer()
                        Text("Wake up Time")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.top, 20)

                    // Summary card (dark rounded)
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("WAKE UP", systemImage: "sun.max")
                                .labelStyle(.titleAndIcon)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.white.opacity(0.85))
                                .symbolVariant(.circle.fill)

                            Text("\(two(wakeHour)).\(two(wakeMinute))")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(gold)
                                .monospacedDigit()
                        }
                        Spacer(minLength: 12)
                        VStack(alignment: .trailing, spacing: 8) {
                            Label("SLEEP", systemImage: "moon.zzz")
                                .labelStyle(.titleAndIcon)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.white.opacity(0.85))
                                .symbolVariant(.fill)

                            Text("\(two(sleepTime.hour)).\(two(sleepTime.minute))")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(.white)
                                .monospacedDigit()
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.28))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding(.horizontal, 22)

                    // Pickers with frosted capsule across the center row
                    ZStack {
                        // Wheel pickers
                        HStack(spacing: 0) {
                            Picker("Hour", selection: $wakeHour) {
                                ForEach(0..<24, id: \.self) { h in
                                    Text(two(h))
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundStyle(wakeHour == h ? gold : .white.opacity(0.6))
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.wheel)

                            Picker("Minute", selection: $wakeMinute) {
                                // 0..59 every minute; use stride(by: 5) if you want 5-min steps
                                ForEach(0..<60, id: \.self) { m in
                                    Text(two(m))
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundStyle(wakeMinute == m ? gold : .white.opacity(0.6))
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.wheel)
                        }
                        .padding(.horizontal, 32)
                        .frame(height: 140)
                        .clipped()

                        // The frosted highlight band (center)
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(Color.white.opacity(0.12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(Color.white.opacity(0.35), lineWidth: 1)
                            )
                            .frame(height: 56)
                            .padding(.horizontal, 32)
                    }
                    .padding(.top, 6)

                    // Save button (big pill)
                    Button {
                        onSave(wakeHour, wakeMinute, sleepTime.hour, sleepTime.minute)
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.black.opacity(0.9))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                LinearGradient(
                                    colors: [.white, .white.opacity(0.86)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                            .shadow(color: .black.opacity(0.25), radius: 4, y: 1)
                            .padding(.horizontal, 22)
                    }
                    .buttonStyle(.plain)

                }
                .padding(.top, 8)
                .padding(.bottom, 16)
            }

           
        
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private func two(_ n: Int) -> String { String(format: "%02d", n) }
}

#Preview {
    WakeTimeSheetView(
        wakeHour: .constant(6),
        wakeMinute: .constant(0)
    ) { _,_,_,_ in }
    .presentationDetents([.fraction(0.45)])
    .presentationCornerRadius(24)
    .presentationDragIndicator(.hidden)
}

