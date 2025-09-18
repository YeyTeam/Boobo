
//
//  WakeTimeSheetView.swift
//  Boobo
//
//  Created by Abdul Jabbar on 18/09/25.
//

import SwiftUI

struct WakeTimeSheetView: View {
    @Binding var wakeHour: Int
    @Binding var wakeMinute: Int
    var onSave: (_ wakeHour: Int, _ wakeMinute: Int, _ sleepHour: Int, _ sleepMinute: Int) -> Void
    
    // MARK: - Sleep time auto-calc
    private var sleepTime: (hour: Int, minute: Int) {
        var h = wakeHour - 8
        if h < 0 { h += 24 }
        return (h, wakeMinute)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with title + close
            HStack {
                Spacer()
                Text("Wake up Time")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                Spacer()
                Button {
                    // dismiss is handled by parent
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            
            // Time cards
            HStack(spacing: 24) {
                VStack(spacing: 6) {
                    Label("WAKE UP", systemImage: "sun.max.fill")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                    Text("\(two(wakeHour)).\(two(wakeMinute))")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.yellow)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(spacing: 6) {
                    Label("SLEEP", systemImage: "moon.zzz.fill")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                    Text("\(two(sleepTime.hour)).\(two(sleepTime.minute))")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.yellow)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
            
            // Time pickers
            HStack(spacing: 0) {
                Picker("Hour", selection: $wakeHour) {
                    ForEach(0..<24, id: \.self) { h in
                        Text(two(h))
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(h == wakeHour ? .yellow : .white.opacity(0.6))
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
                .labelsHidden()
                
                Picker("Minute", selection: $wakeMinute) {
                    ForEach(Array(stride(from: 0, through: 55, by: 5)), id: \.self) { m in
                        Text(two(m))
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(m == wakeMinute ? .yellow : .white.opacity(0.6))
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
                .labelsHidden()
            }
            .pickerStyle(.wheel)
            .frame(height: 140)
            
            // Save button
            Button {
                onSave(wakeHour, wakeMinute, sleepTime.hour, sleepTime.minute)
            } label: {
                Text("Save")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white.opacity(0.85))
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding(.vertical)
        .background(
            LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 90/255,  green: 134/255, blue: 179/255), location: 0.00), // top  ~#5A86B3
                        .init(color: Color(red: 71/255,  green: 115/255, blue: 164/255), location: 0.35), // mid1 ~#4773A4
                        .init(color: Color(red: 45/255,  green:  94/255, blue: 142/255), location: 0.70), // mid2 ~#2D5E8E
                        .init(color: Color(red: 18/255,  green:  58/255, blue:  98/255), location: 1.00)  // bottom ~#123A62
                    ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

// Helper
private func two(_ n: Int) -> String {
    String(format: "%02d", n)
}

#Preview {
    WakeTimeSheetView(wakeHour: .constant(6), wakeMinute: .constant(0)) { wH, wM, sH, sM in
        print("Saved wake \(wH):\(wM) sleep \(sH):\(sM)")
    }
    .presentationDetents([.fraction(0.4)])
}
