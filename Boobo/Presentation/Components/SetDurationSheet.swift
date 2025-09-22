//
//  SetDurationSheet.swift
//  Boobo
//
//  Created by Aditya Rizki on 18/09/25.
//

import SwiftUI

struct SetDurationSheet: View {
    @Binding var isFavoriteSheetOpen: Bool
    @Binding var isPresented: Bool
    var initialDuration: TimeInterval
    var onSave: (TimeInterval) -> Void
    var onDismiss: () -> Void
    
    @State private var selectedDuration: TimeInterval
    
    init(isFavoriteSheetOpen: Binding<Bool>,
         isPresented: Binding<Bool>,
         initialDuration: TimeInterval,
         onSave: @escaping (TimeInterval) -> Void,
         onDismiss: @escaping () -> Void) {
        self._isFavoriteSheetOpen = isFavoriteSheetOpen
        self._isPresented = isPresented
        self.initialDuration = initialDuration
        self.onSave = onSave
        self.onDismiss = onDismiss
        self._selectedDuration = State(initialValue: initialDuration)
    }
    
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            ZStack {
                Text("Favorite Playlist")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)

                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                        onDismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.top, 8)       // ruang dari rounded corner
            .padding(.bottom, 12)
            
            // Picker
            CustomTimePicker(selectedHour: $selectedHour, selectedMinute: $selectedMinute)
                .onChange(of: selectedHour) { _, _ in
                    selectedDuration = TimeInterval(selectedHour * 3600 + selectedMinute * 60)
                }
                .onChange(of: selectedMinute) { _, _ in
                    selectedDuration = TimeInterval(selectedHour * 3600 + selectedMinute * 60)
                }
                .onAppear {
                    let total = Int(initialDuration)
                    selectedHour = max(0, min(23, total / 3600))
                    selectedMinute = max(0, min(59, (total % 3600) / 60))
                    selectedDuration = TimeInterval(selectedHour * 3600 + selectedMinute * 60)
                }
            
            // Save button
            Button(action: {
                onSave(selectedDuration)
                isPresented = false
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
            .padding(.top, 12)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }
}

struct CustomTimePicker: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    
    let hours = Array(0..<24)
    let minutes = Array(0..<60)
    
    var body: some View {
        HStack(spacing: 24) {
            // Hour picker
            HStack(spacing: 4) {
                Picker("Jam", selection: $selectedHour) {
                    ForEach(hours, id: \.self) { hour in
                        Text(String(format: "%02d", hour))
                            .tag(hour)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                
                Text("Hour")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            // Minute picker
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
    SetDurationSheet(
        isFavoriteSheetOpen: .constant(true),
        isPresented: .constant(true),
        initialDuration: 3600,
        onSave: { _ in },
        onDismiss: {}
    )
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
