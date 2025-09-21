//
//  BedtimeView.swift
//  Boobo
//
//  Created by Aditya Rizki on 15/09/25.
//

import SwiftUI

struct BedtimeView: View {
    @State private var isOn = false
    @State private var isWakeUpTimeSheetPresented = false
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        ZStack {
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
                    Button (action: {
                        isWakeUpTimeSheetPresented = true
                    }) {
                        Text("Change")
                            .font(.body)
                            .foregroundColor(.gray)
                            .underline(true, color: .gray)
                    }
                }
                Text("22.00")
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
                    HStack {
                        Image(systemName: "lamp.floor")
                        Text("Turn off the bright lights")
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    Divider()
                        .frame(height: 1)
                        .background(.white.opacity(0.5))
                    HStack {
                        Image(systemName: "speaker.slash")
                        Text("Keep the room quiet to make it easier to fall asleep")
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    Divider()
                        .frame(height: 1)
                        .background(.white.opacity(0.5))
                    HStack {
                        Image(systemName: "thermometer.variable")
                        Text("Adjust Room Temperature")
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    Divider()
                        .frame(height: 1)
                        .background(.white.opacity(0.5))
                    HStack {
                        Image(systemName: "laptopcomputer.slash")
                        Text("Avoid Blue Light")
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                }
                .padding(.vertical)
                .background(Color.black.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 2)
                )
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
            .sheet(isPresented: $isWakeUpTimeSheetPresented) {
                WakeUpTimeSheet()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.thinMaterial)
            }
            
            // Overlay Face Down Phone
            if sessionManager.isOverlayShow {
                PhoneFaceDownOverlay()
                    .zIndex(999)
            }

        }
    }
}

struct WakeUpTimeSheet: View {
    @State private var selectedTime = UserDefaults.standard.object(forKey: "wakeUpTime") as? Date ?? Date()
    
    // computed property: sleepTime = selectedTime - 8 jam
    var sleepTime: Date {
        Calendar.current.date(byAdding: .hour, value: -8, to: selectedTime) ?? selectedTime
    }
    
    @EnvironmentObject var routeManager: RouteManager
    
    var body: some View {
        VStack {
            HStack {
                Text("Wake Up Time")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                Image(systemName: "x.circle.fill")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth : .infinity)
            
            HStack {
                VStack {
                    Text("WAKE UP")
                        .foregroundStyle(.gray)
                    Text(selectedTime.formatted(
                        date: .omitted, time: .shortened))
                    .foregroundColor(Color(hex: "FEBB2E"))
                    .font(.title2.bold())
                }
                Spacer()
                VStack {
                    Text("SLEEP")
                        .foregroundStyle(.gray)
                    Text(sleepTime.formatted(date: .omitted, time: .shortened))
                        .foregroundStyle(.white)
                        .font(.title2.bold())
                    
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black.opacity(0.2))
            )
            
            DatePicker("Pilih Jam", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(height : 150)
            Button(action: {
                // Hitung sleep time (8 jam sebelum bangun)
                let sleepTime = selectedTime.addingTimeInterval(-8 * 60 * 60)
                
                // Simpan ke UserDefaults
                UserDefaults.standard.set(selectedTime, forKey: "wakeUpTime")
                UserDefaults.standard.set(sleepTime, forKey: "sleepTime")
                
                let components = Calendar.current.dateComponents([.hour, .minute, .second], from: sleepTime)
                
                NotificationManager.shared.scheduleDaily(hour: components.hour ?? 22, minute: components.minute ?? 0, second: components.second ?? 0, router: routeManager)
                
                print("Wake Up: \(selectedTime)")
                print("Sleep: \(sleepTime)")
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(30)
        .background(.blue.opacity(0.5))
        .ignoresSafeArea()
    }
}

#Preview {
    let sessionManager = SessionManager()
    
    BedtimeView()
        .environmentObject(sessionManager)
}
