import SwiftUI

struct NotificationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var notifications: [NotificationItem] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Text("Notification")
                    .font(.headline)
                    .fontWeight(.medium)
                
                Spacer()
                
                // Invisible spacer to center the title
                Image(systemName: "chevron.left")
                    .foregroundColor(.clear)
                    .font(.title2)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color.white)
            
            // Notifications List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(notifications) { notification in
                        NotificationRow(notification: notification)
                        
                        if notification.id != notifications.last?.id {
                            Divider()
                                .padding(.leading, 60)
                        }
                    }
                }
                .padding(.top, 10)
            }
            .background(Color.white)
        }
        .background(Color.gray.opacity(0.05))
        .navigationBarHidden(true)
        .onAppear {
            loadNotifications()
        }
    }
    
    private func loadNotifications() {
        notifications = NotificationData.sampleNotifications
    }
}

struct NotificationRow: View {
    let notification: NotificationItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Bell Icon
            Image(systemName: "bell")
                .foregroundColor(.blue)
                .font(.title3)
                .frame(width: 24, height: 24)
                .padding(.top, 2)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text(notification.timeAgo)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text(notification.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

// MARK: - Data Models
struct NotificationItem: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let timeAgo: String
    let timestamp: Date
    
    init(id: String = UUID().uuidString, title: String, description: String, timeAgo: String, timestamp: Date = Date()) {
        self.id = id
        self.title = title
        self.description = description
        self.timeAgo = timeAgo
        self.timestamp = timestamp
    }
}

// MARK: - JSON Data Source
struct NotificationData {
    static let sampleNotifications: [NotificationItem] = [
        NotificationItem(
            title: "2025 Career Fair",
            description: "Join this 1st saturday in NIBM premises for valuable opportunities",
            timeAgo: "1 min ago"
        ),
        NotificationItem(
            title: "Someone loss water bottle",
            description: "someone forgot their water bottle in the cafeteria. please come to the office with proof and bring it.",
            timeAgo: "10 min ago"
        ),
        NotificationItem(
            title: "Exam Alert",
            description: "Web Api Development Exam time added. please check lms for more details",
            timeAgo: "1 hour ago"
        ),
        NotificationItem(
            title: "CW Alert",
            description: "Web Api Development CW added. please check lms for more details",
            timeAgo: "1 hour ago"
        ),
        NotificationItem(
            title: "2025 Hackathon in NIBM",
            description: "Please meet the leo club to get more details about the Hackathon",
            timeAgo: "1 hour ago"
        )
    ]
    
    // JSON String for easy modification
    static let notificationsJSON = """
    [
        {
            "id": "1",
            "title": "2025 Career Fair",
            "description": "Join this 1st saturday in NIBM premises for valuable opportunities",
            "timeAgo": "1 min ago"
        },
        {
            "id": "2",
            "title": "Someone loss water bottle",
            "description": "someone forgot their water bottle in the cafeteria. please come to the office with proof and bring it.",
            "timeAgo": "10 min ago"
        },
        {
            "id": "3",
            "title": "Exam Alert",
            "description": "Web Api Development Exam time added. please check lms for more details",
            "timeAgo": "1 hour ago"
        },
        {
            "id": "4",
            "title": "CW Alert",
            "description": "Web Api Development CW added. please check lms for more details",
            "timeAgo": "1 hour ago"
        },
        {
            "id": "5",
            "title": "2025 Hackathon in NIBM",
            "description": "Please meet the leo club to get more details about the Hackathon",
            "timeAgo": "1 hour ago"
        }
    ]
    """
    
    // Function to load from JSON
    static func loadFromJSON() -> [NotificationItem] {
        guard let data = notificationsJSON.data(using: .utf8) else {
            return sampleNotifications
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([NotificationItem].self, from: data)
        } catch {
            print("Error decoding notifications: \(error)")
            return sampleNotifications
        }
    }
}

// Preview
struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
