import SwiftUI

struct LoginView: View {
    @State private var username: String = "COBSCCOMP4231P-021"
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var rememberMe: Bool = false
    @State private var navigateToHome = false
    
    // Animation states
    @State private var headerOpacity: Double = 0
    @State private var headerOffset: CGFloat = -100
    @State private var formOpacity: Double = 0
    @State private var formOffset: CGFloat = 100
    @State private var buttonScale: CGFloat = 0.8
    @State private var buttonOpacity: Double = 0

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                   
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )

                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 80, height: 80)
                                    .shadow(radius: 5)

                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 120, height: 120)
                                        .shadow(radius: 10)

                                    Image("logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 120)
                                }
                            }

                            Text("Explore,Navigate,Success")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 60)
                        .padding(.bottom, 40)
                        .opacity(headerOpacity)
                        .offset(y: headerOffset)
                    }
                    .frame(height: geometry.size.height * 0.35)

                    // Animated Form Section
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .frame(height: 50)
                            .offset(y: -25)

                        VStack(spacing: 24) {
                            Text("Log In")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                                .padding(.top, -25)

                            // Animated Username Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Username")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                TextField("", text: $username)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            .opacity(formOpacity)
                            .offset(y: formOffset)
                            .animation(.easeOut(duration: 0.6).delay(0.1), value: formOpacity)

                            // Animated Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                HStack {
                                    if isPasswordVisible {
                                        TextField("", text: $password)
                                            .textFieldStyle(PlainTextFieldStyle())
                                    } else {
                                        SecureField("", text: $password)
                                            .textFieldStyle(PlainTextFieldStyle())
                                    }

                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            isPasswordVisible.toggle()
                                        }
                                    }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                            .opacity(formOpacity)
                            .offset(y: formOffset)
                            .animation(.easeOut(duration: 0.6).delay(0.2), value: formOpacity)

                            // Animated Remember Me & Forgot Password
                            HStack {
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        rememberMe.toggle()
                                    }
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                            .foregroundColor(rememberMe ? .blue : .gray)
                                            .scaleEffect(rememberMe ? 1.1 : 1.0)
                                        Text("Remember me")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }

                                Spacer()

                                NavigationLink(destination: ForgotPasswordView()) {
                                    Text("Forgot Password ?")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                            .opacity(formOpacity)
                            .offset(y: formOffset)
                            .animation(.easeOut(duration: 0.6).delay(0.3), value: formOpacity)

                            NavigationLink(
                                destination: MainTabView(),
                                isActive: $navigateToHome,
                                label: { EmptyView() }
                            )

                            // Animated Login Button
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    buttonScale = 0.95
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        buttonScale = 1.0
                                    }
                                    navigateToHome = true
                                }
                            }) {
                                Text("Log In")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(12)
                                    .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                            .scaleEffect(buttonScale)
                            .opacity(buttonOpacity)
                            .animation(.easeOut(duration: 0.6).delay(0.4), value: buttonOpacity)

                      
                            HStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                                Text("Or")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            .padding(.vertical, 8)
                            .opacity(formOpacity)
                            .offset(y: formOffset)
                            .animation(.easeOut(duration: 0.6).delay(0.5), value: formOpacity)

                         
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    
                                }
                            }) {
                                HStack(spacing: 12) {
                                    Image("guest")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text("Continue as Guest")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                            .opacity(formOpacity)
                            .offset(y: formOffset)
                            .animation(.easeOut(duration: 0.6).delay(0.6), value: formOpacity)

                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        .background(Color.white)
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .onAppear {
                startLoginAnimations()
            }
        }
        .navigationBarHidden(true)
    }
    
    private func startLoginAnimations() {
        // Header animation
        withAnimation(.easeOut(duration: 0.8)) {
            headerOpacity = 1.0
            headerOffset = 0
        }
        
        // Form elements animation with staggered delays
        withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
            formOpacity = 1.0
            formOffset = 0
        }
        
        // Button animation
        withAnimation(.easeOut(duration: 0.6).delay(0.4)) {
            buttonOpacity = 1.0
            buttonScale = 1.0
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
