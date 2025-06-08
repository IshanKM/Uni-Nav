import SwiftUI

struct TimetableCard: View {
    let item: TimetableItem
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 12) {
            Text(item.subject)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.gray)
                    .font(.caption)
                Text(item.time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "location")
                    .foregroundColor(.gray)
                    .font(.caption)
                Text(item.location)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            if !item.batch.isEmpty {
                HStack {
                    Image(systemName: "person.2")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Text(item.batch)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
        
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
