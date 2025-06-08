import SwiftUI

struct AccountView: View {
    @State private var navigateToLogin = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 16) {
                    Circle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text("S.G.I.K")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                        )
                    
                    Text("S.G.I.K")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text("Student ID: COBSCCOMP4231P-021")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)

                VStack(spacing: 0) {
                    AccountRow(icon: "person.circle", title: "Profile Settings")
                    AccountRow(icon: "bell", title: "Notifications")
                    AccountRow(icon: "lock", title: "Privacy & Security")
                    AccountRow(icon: "questionmark.circle", title: "Help & Support")
                    
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                                .font(.title3)
                                .frame(width: 24)
                            
                            Text("Logout")
                                .font(.subheadline)
                                .foregroundColor(.red)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                    .background(Color.white)
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Account")
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct AccountRow: View {
    let icon: String
    let title: String
    var isDestructive: Bool = false
    
    var body: some View {
        Button(action: {
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .foregroundColor(isDestructive ? .red : .gray)
                    .font(.title3)
                    .frame(width: 24)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(isDestructive ? .red : .black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color.white)
    }
}
