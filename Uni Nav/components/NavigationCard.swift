import SwiftUI

struct NavigationCard: View {
    let title: String
    let imageName: String

    var body: some View {
        VStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 130)
                .cornerRadius(12)

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
