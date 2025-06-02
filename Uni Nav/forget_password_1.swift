//
//  forget_password_1.swift
//  Uni Nav
//
//  Created by Heshan Dunumala on 2025-06-02.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var username: String = ""
    @State private var emailAddress: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Navigation Header
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
                
                // Invisible spacer to center the title
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .opacity(0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Description Text
            VStack(alignment: .leading, spacing: 8) {
                Text("To reset your password, submit your username or your email address below. If we can find you in the database, an email will be sent to your email address, with instructions how to get access again.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineSpacing(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            
            // Search By Username Section
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
                    // Handle username search
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
            
            // Search By Email Address Section
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
                    // Handle email search
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
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
    
    // MARK: - Actions
    private func searchByUsername() {
        // Implement username search logic
        print("Searching by username: \(username)")
        // Add your API call or validation logic here
    }
    
    private func searchByEmail() {
        // Implement email search logic
        print("Searching by email: \(emailAddress)")
        // Add your API call or validation logic here
    }
}

// MARK: - Preview
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}


