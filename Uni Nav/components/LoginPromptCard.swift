import SwiftUI

struct LoginPromptCard: View {
    var body: some View {
        VStack(spacing: 20) {
          
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 80, height: 80)
                
                Image(systemName: "person.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            
           
            VStack(spacing: 8) {
                Text("Login Required")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text("Please log in to view your personalized timetable and access all features")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
            
           
            NavigationLink(destination: LoginView()) {
                HStack(spacing: 8) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 16))
                    
                    Text("Login Now")
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
            
           
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 35)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.15), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 20)
    }
}
