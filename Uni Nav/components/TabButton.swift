import SwiftUI

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .medium : .regular)
                    .foregroundColor(isSelected ? .blue : .gray)
                
                if isSelected {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 2)
                        .cornerRadius(1)
                }
            }
        }
    }
}


