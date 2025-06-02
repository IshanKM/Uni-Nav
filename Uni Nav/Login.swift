import SwiftUI

struct LoginView: View {
    @State private var username: String = "COBSCCOMP4231P-021"
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var rememberMe: Bool = false
    @State private var navigateToHome = false

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
                    }
                    .frame(height: geometry.size.height * 0.35)

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
                                        isPasswordVisible.toggle()
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

                            HStack {
                                Button(action: {
                                    rememberMe.toggle()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                            .foregroundColor(rememberMe ? .blue : .gray)
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

                            // ✅ Hidden NavigationLink triggered by state
                            NavigationLink(
                                destination: HomeView(),
                                isActive: $navigateToHome,
                                label: { EmptyView() }
                            )

                            Button(action: {
                                // Handle login logic here
                                // On success:
                                navigateToHome = true
                            }) {
                                Text("Log In")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                            }

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

                            Button(action: {
                                // Handle guest login
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "person.circle")
                                        .foregroundColor(.gray)
                                    Text("Continue as Guest")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        .background(Color.white)
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
