//
//  SetDurationSheet.swift
//  Boobo
//
//  Created by Aditya Rizki on 18/09/25.
//

import SwiftUI

struct SetDurationSheet: View {
    @Binding var isFavoriteSheetOpen: Bool
    @State private var selectedTime = Date()
    
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
            
            CustomTimePicker()
            
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
    }
}

struct CustomTimePicker: View {
    @State private var selectedHour = 6
    @State private var selectedMinute = 0
    
    let hours = Array(0..<24)
    let minutes = Array(0..<60)
    
    var body: some View {
        HStack(spacing: 8) {
            // Hour picker + label "hh"
            HStack(spacing: 4) {
                Picker("Jam", selection: $selectedHour) {
                    ForEach(hours, id: \.self) { hour in
                        Text(String(format: "%02d", hour))
                            .tag(hour)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80) // atur lebar roda
                Text("Hour")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            // Minute picker + label "mm"
            HStack(spacing: 4) {
                Picker("Menit", selection: $selectedMinute) {
                    ForEach(minutes, id: \.self) { minute in
                        Text(String(format: "%02d", minute))
                            .tag(minute)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                Text("Minute")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .frame(height: 200)
        .padding()
    }
}




#Preview {
    SetDurationSheet(isFavoriteSheetOpen: .constant(true))
        .background(
            LinearGradient(
                colors: [
                    Color(hex: "3D6196"),
                    Color(hex: "5F7BA5"),
                    Color(hex: "12416D")
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
}
