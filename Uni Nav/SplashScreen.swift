//
//  ContentView.swift
//  Uni Nav
//
//  Created by ISHAN  on 2025-05-29.
//


// SplashScreenView.swift
import SwiftUI

struct SplashScreenView: View {
    @State private var progress: Double = 0.0
    
    var body: some View {
        ZStack {
            // Blue gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Logo section
                VStack(spacing: 20) {
                    // Circular logo with compass design
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 120, height: 120)
                            .shadow(radius: 10)
                        
                        // Your compass/NAVI logo here
                        Text("NAVI")
                            .font(.headline)
                            .foregroundColor(.purple)
                    }
                    
                    // Text content
                    VStack(spacing: 8) {
                        Text("Campus Navigator")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                        
                        Text("Explore Navigate Success")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                Spacer()
                
                // Bottom section
                VStack(spacing: 16) {
                    VStack(spacing: 4) {
                        Text("Copyright © 2024 NAVI University")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.7))
                        Text("All Rights Reserved")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    // Progress bar
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        .frame(width: 120)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            startLoading()
        }
    }
    
    private func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if progress < 1.0 {
                progress += 0.02
            } else {
                timer.invalidate()
                // Navigate to main app
            }
        }
    }
}

#Preview {
    SplashScreenView()
}

