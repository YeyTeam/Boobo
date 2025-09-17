//
//  SleepHygieneView.swift
//  Boobo
//
//  Created by Aditya Rizki on 15/09/25.
//

import SwiftUI

struct SleepHygieneStepContent: Hashable {
    let title: String
    let description: String
    let image: String
}

struct SleepHygieneView: View {
    @EnvironmentObject var router: RouteManager
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var currentStep = 0
    @State private var dragOffset: CGFloat = 0
    
    //    private let totalSteps = 4
    
    private let stepContents: [SleepHygieneStepContent] = [
        SleepHygieneStepContent(title: "Turn Off the Bright Lights", description: "Keep the room dark or use a dim night light.", image: "lamp"),
        SleepHygieneStepContent(title: "Keep the room quiet to make it easier to fall asleep", description: "A peaceful room helps your mind rest.", image: "mute"),
        SleepHygieneStepContent(title: "Adjust Room Temperature", description: "A slightly cooler temperature helps you fall asleep.", image: "snow"),
        SleepHygieneStepContent(title: "Avoid Blue Light", description: "Turn off the TV and other screens. Less blue light helps you get sleepy.", image: "screen")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Step Indicator
            StepIndicatorView(currentStep: currentStep, totalSteps: stepContents.count)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // Step Content
            TabView(selection: $currentStep) {
                ForEach(Array(stepContents.enumerated()), id: \.offset) { index, content in
                    StepContentView(title: content.title, description: content.description, image: content.image)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: currentStep)
            
            // Navigation Button
            
                if currentStep < stepContents.count - 1 {
                    Button("Next Step") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep += 1
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                } else {
                    Button("Finish") {
                        router.resetRoot()
                        //sessionManager.setupSleepTime()
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            
        }
        .padding(.vertical, 46)
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("sleep-hygiene-bg")
                .resizable()
                .scaledToFill()
        )
        .ignoresSafeArea()
    }
}

// MARK: - Step Indicator View
struct StepIndicatorView: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalSteps, id: \.self) { step in
                Rectangle()
                    .fill(step <= currentStep ? Color(hex: "FEBB2E") : Color.gray.opacity(0.3))
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut(duration: 0.3), value: currentStep)
            }
        }
    }
}

// MARK: - Step Content View
struct StepContentView: View {
    let title: String
    let description: String
    let image: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Button Styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2)
                )
                .cornerRadius(8)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
        }
}

#Preview {
    SleepHygieneView()
}

