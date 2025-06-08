
struct AnnouncementItem {
    let title: String
    let date: String
    let description: String
}

struct EventItem {
    let title: String
    let date: String
    let description: String
}


let announcementItems = [
    AnnouncementItem(
        title: "Exam Alert",
        date: "June 4",
        description: "Web Api Development Exam time added. please check lms for more details."
    ),
    AnnouncementItem(
        title: "Library Notice",
        date: "June 3",
        description: "Library will be closed on June 6th for maintenance. Please plan accordingly."
    ),
    AnnouncementItem(
        title: "Assignment Deadline",
        date: "June 2",
        description: "iOS Development assignment submission deadline extended to June 10th."
    )
]

let eventItems = [
    EventItem(
        title: "2025 Career Fair",
        date: "June 05",
        description: "Join this 1st saturday in NIBM premises for valuable opportunities. please contact program office for more info."
    ),
    EventItem(
        title: "Tech Workshop",
        date: "June 08",
        description: "Learn about latest iOS development trends and SwiftUI best practices."
    ),
    EventItem(
        title: "Sports Day",
        date: "June 12",
        description: "Annual sports day with various competitions. Registration starts June 6th."
    )
]
