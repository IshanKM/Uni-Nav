import SwiftUI

struct ForgotPasswordView: View {
    @State private var username: String = ""
    @State private var emailAddress: String = ""
    @State private var showPasswordResetModal: Bool = false
    @State private var navigateToLogin = false
    @State private var showEmptyUsernameAlert = false // ADDED
    @State private var showEmptyEmailAlert = false // ADDED
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack {

                VStack(alignment: .leading, spacing: 0) {
   
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        }

                        Spacer()

                        Text("Forgot password")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)

                        Spacer()

                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .opacity(0)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("To reset your password, submit your username or your email address below. If we can find you in the database, an email will be sent to your email address, with instructions how to get access again.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .lineSpacing(2)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)

     
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Search By Username")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)

                        TextField("Enter Your Username", text: $username)
                            .font(.system(size: 16))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )

                        Button(action: {
                            searchByUsername()
                        }) {
                            Text("Search")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)

      
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Search By Email Address")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)

                        TextField("Enter your Email Address", text: $emailAddress)
                            .font(.system(size: 16))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)

                        Button(action: {
                            searchByEmail()
                        }) {
                            Text("Search")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)

                    Spacer()

                    
                    NavigationLink(
                        destination: LoginView(),
                        isActive: $navigateToLogin,
                        label: {
                            EmptyView()
                        }
                    )
                }
                .background(Color.white)
                .blur(radius: showPasswordResetModal ? 2 : 0)
                .disabled(showPasswordResetModal)

            
                if showPasswordResetModal {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()

                   
                    PasswordResetModal(
                        isPresented: $showPasswordResetModal,
                        onContinue: {
                            navigateToLogin = true
                        }
                    )
                }
            }
            .navigationBarHidden(true)
        
            .alert("Username Required", isPresented: $showEmptyUsernameAlert) {
                Button("OK") { }
            } message: {
                Text("Please enter your username to search.")
            }
           
            .alert("Email Required", isPresented: $showEmptyEmailAlert) {
                Button("OK") { }
            } message: {
                Text("Please enter your email address to search.")
            }
        }
    }

   
    private func searchByUsername() {
        if username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showEmptyUsernameAlert = true
            return
        }
        
        print("Searching by username: \(username)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showPasswordResetModal = true
        }
    }

   
    private func searchByEmail() {
        if emailAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showEmptyEmailAlert = true
            return
        }
        
        print("Searching by email: \(emailAddress)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showPasswordResetModal = true
        }
    }
}


struct PasswordResetModal: View {
    @Binding var isPresented: Bool
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Password reset")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("If you supplied a correct username or unique email address then an email should have been sent to you. It contains easy instructions to confirm and complete this password change. If you continue to have difficulty, please contact the site administrator.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineSpacing(2)
                    .multilineTextAlignment(.leading)

                Button(action: {
                    isPresented = false
                    onContinue()
                }) {
                    Text("Continue")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 8)
            }
            .padding(24)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 40)
        .transition(.scale.combined(with: .opacity))
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
