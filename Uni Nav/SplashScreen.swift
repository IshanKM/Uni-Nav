import SwiftUI

struct SplashScreenView: View {
    @State private var progress: Double = 0.0
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            if isActive {
                // 🔁 Navigate to home screen here
                HomeView()
            } else {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()

                    VStack {
                        Spacer()
                        
                        // Logo
                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 120, height: 120)
                                    .shadow(radius: 10)
                                
                                Text("NAVI")
                                    .font(.headline)
                                    .foregroundColor(.purple)
                            }

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

                        // Footer
                        VStack(spacing: 16) {
                            VStack(spacing: 4) {
                                Text("Copyright © 2024 NAVI University")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.7))
                                Text("All Rights Reserved")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.7))
                            }

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
        }
    }

    private func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if progress < 1.0 {
                progress += 0.02
            } else {
                timer.invalidate()
                // 🔁 Trigger navigation
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
