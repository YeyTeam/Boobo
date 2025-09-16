//
//  TimePicker.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//

import SwiftUI

struct TimePicker: View {
   private let hours = Array(0..<24)
   private let minutes = Array(0..<60)
   
   private var repeatedHours: [Int] { Array(repeating: hours, count: 3).flatMap { $0 } }
   private var repeatedMinutes: [Int] { Array(repeating: minutes, count: 3).flatMap { $0 } }
   
   @State private var selectedHourIndex: Int
   @State private var selectedMinuteIndex: Int
   
   init() {
       let middleHour = 24
       let middleMinute = 60
       _selectedHourIndex = State(initialValue: middleHour)
       _selectedMinuteIndex = State(initialValue: middleMinute)
   }
   
   var selectedHour: Int { repeatedHours[selectedHourIndex] }
   var selectedMinute: Int { repeatedMinutes[selectedMinuteIndex] }
    
    var body: some View {
        ZStack{
            HStack{
                Picker("Jam", selection: $selectedHourIndex) {
                    ForEach(0..<repeatedHours.count, id: \.self) { index in
                        Text(String(format: "%02d", repeatedHours[index]))
                            .tag(index)
                            .foregroundStyle(Color.white)

                    }
                }
                .pickerStyle(.wheel)
                .clipped()
                .onChange(of: selectedHourIndex) { _, newValue in
                    if newValue < 24 {
                        selectedHourIndex = newValue + 24
                    } else if newValue >= 48 {
                        selectedHourIndex = newValue - 24
                    }
                }
                
                Text(":")
                    .foregroundStyle(.white)
                
                Picker("Jam", selection: $selectedMinuteIndex) {
                        ForEach(0..<repeatedMinutes.count, id: \.self) { index in
                            Text(String(format: "%02d", repeatedMinutes[index]))
                                .tag(index)
                                .foregroundStyle(Color.white)

                        }
                    }
                    .pickerStyle(.wheel)
                    .clipped()
                    .onChange(of: selectedMinuteIndex) { _, newValue in
                        if newValue < 60 {
                            selectedMinuteIndex = newValue + 60
                        } else if newValue >= 120 {
                            selectedMinuteIndex = newValue - 60
                        }
                    }
                .pickerStyle(.wheel)
                .clipped(antialiased: true)
            }
        }
//        .background{
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.buttonPrimary)
//        }
//        

        .frame(height : 100)
        
    }
}

#Preview {
    VStack{
        TimePicker()

    }
    .background(
        Image("BackgroundA"))
}
