import SwiftUI

struct SplashScreenView: View {
    
    @State private var progress: Double = 0.0
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0
    @State private var textOpacity: Double = 0
    @State private var textOffset: CGFloat = 50
    @State private var progressOpacity: Double = 0

    var body: some View {
        NavigationStack {
            if isActive {
                LoginView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
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
                        
                        VStack(spacing: 20) {
                    
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 120, height: 120)
                                    .shadow(radius: 10)
                                    .scaleEffect(logoScale)
                                    .opacity(logoOpacity)
                                
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .scaleEffect(logoScale)
                                    .opacity(logoOpacity)
                            }

                            VStack(spacing: 8) {
                                Text("Campus Navigator")
                                    .font(.title2)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                    .opacity(textOpacity)
                                    .offset(y: textOffset)

                                Text("Explore Navigate Success")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .opacity(textOpacity)
                                    .offset(y: textOffset)
                            }
                        }

                        Spacer()


                        VStack(spacing: 16) {
                            VStack(spacing: 4) {
                                Text("Copyright © 2025 NIBM Campus")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.7))
                                    .opacity(progressOpacity)
                                Text("All Rights Reserved")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.7))
                                    .opacity(progressOpacity)
                            }

                            ProgressView(value: progress, total: 1.0)
                                .progressViewStyle(LinearProgressViewStyle(tint: .white))
                                .frame(width: 120)
                                .opacity(progressOpacity)
                                .scaleEffect(x: progressOpacity, y: 1.0)
                        }
                        .padding(.bottom, 50)
                    }
                }
                .onAppear {
                    startAnimations()
                }
            }
        }
        .animation(.easeInOut(duration: 0.8), value: isActive)
    }

    private func startAnimations() {
        
        withAnimation(.easeOut(duration: 0.8)) {
            logoOpacity = 1.0
            logoScale = 1.0
        }
        

        withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
            textOpacity = 1.0
            textOffset = 0
        }
        

        withAnimation(.easeOut(duration: 0.5).delay(0.6)) {
            progressOpacity = 1.0
        }
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            startLoading()
        }
    }

    private func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if progress < 1.0 {
                progress = min(progress + 0.04, 1.0)
            } else {
                timer.invalidate()
                withAnimation(.easeInOut(duration: 0.5)) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
