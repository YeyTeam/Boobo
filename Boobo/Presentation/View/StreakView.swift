//
//  ProgressView.swift
//  Boobo
//
//  Created by Aditya Rizki on 16/09/25.
//

import SwiftUI

struct StreakView: View {
    @State var totalStreak: Int = 9 //UserDefaults.standard.integer(forKey: "totalStreak")
    @State var showAlert : Bool = false
    
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Sleep Progress")
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                Text("Every 14 nights of sleeping on time becomes one streak. Don’t break the streak and let each streak bring you closer to better rest.")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 48)
                    .padding(.top, 8)
                HStack(alignment: .top) {
                    VStack {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.white)
                            Text("Total Streak")
                                .foregroundColor(.white)
                                .font(.caption.weight(.medium))
                        }
                        Text("\(totalStreak)")
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.bold))
                    }
                    .padding(12)
                    .background(.ultraThinMaterial.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    
                    Button(action: {
                        showAlert = true
                    }){
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                            .font(.title3.weight(.bold))
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title:
                                Text("Streak"),
                            message:
                                Text("Your streak counts only when you put your phone face down at your set bedtime reminder. Miss it once, and the streak resets, you’ll start again from day one.")
                           
                        )
                    }
                    
                }
                .padding(.bottom)
                
                
                ZStack(alignment : .top){
                    VStack{
                        ForEach(0...1, id: \.self) { week in
                            HStack {
                                Spacer()
                                ForEach(1...7, id: \.self) { day in
                                    VStack {
                                        Text("Day \(day+(week*7))")
                                            .font(.caption2.weight(.bold))
                                            .foregroundColor(.white)
                                        VStack {
                                            Image(systemName: ( (week * 7) + day ) <= totalStreak ? "moon.fill" : "moon")
                                                .font(.body)
                                                .foregroundColor(.white)
                                                .padding(8)
                                                .background(( (week * 7) + day ) <= totalStreak ? .primaryYellow : .gray)
                                                .clipShape(Circle())
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .frame(maxWidth : .infinity)
                            .padding(.vertical)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 12)
                        }
                        Spacer()
                    }
                    
                    if totalStreak >= 14 {
                        Image("Streak")
                        
                    }
                }
                
                Spacer()
                
            }
            .padding(.top, 64)
            .padding(.horizontal, 13)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("progress-bg")
                    .resizable()
                    .scaledToFill()
                    .overlay(
                        .black.opacity(0.25)
                    )
            )
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    let routeManager = RouteManager()
    let sessionManager = SessionManager()
    HomeView()
        .environmentObject(routeManager)
        .environmentObject(sessionManager)
//    StreakView()
        
}
