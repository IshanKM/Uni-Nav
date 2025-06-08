import SwiftUI

struct PlacesData: Identifiable {
    let id: Int
    let name: String
    let isAvailable: Bool
    let color: Color
    let floor: String
    let crowdLevel: String
    let category: String
    let description: String
    let facilities: [Facility]
    let mainImage: String // Main header image
    let galleryImages: [String] // Gallery images
    let capacity: Int
    let features: [String]
}

struct Facility: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let isAvailable: Bool
}


struct PlaceCategory {
    let id: Int
    let name: String
    let icon: String
    let iconColor: Color
    let location: String
}


struct PlaceItem {
    let icon: String
    let iconColor: Color
    let name: String
    let location: String
}


let places = [
    PlaceItem(icon: "building.2", iconColor: .blue, name: "Lecture Halls", location: "Colombo Branch"),
    PlaceItem(icon: "flask", iconColor: .red, name: "Labs", location: "Colombo Branch"),
    PlaceItem(icon: "book", iconColor: .yellow, name: "Libraries", location: "Colombo Branch"),
    PlaceItem(icon: "desk", iconColor: .cyan, name: "Study Areas", location: "Colombo Branch"),
    PlaceItem(icon: "briefcase", iconColor: .purple, name: "Office", location: "Colombo Branch"),
    PlaceItem(icon: "fork.knife", iconColor: .green, name: "Cafeteria", location: "Colombo Branch")
]


let placesCategories = [
    PlaceCategory(id: 1, name: "Lecture Halls", icon: "building.2", iconColor: .blue, location: "Colombo Branch"),
    PlaceCategory(id: 2, name: "Labs", icon: "flask", iconColor: .red, location: "Colombo Branch"),
    PlaceCategory(id: 3, name: "Libraries", icon: "book", iconColor: .yellow, location: "Colombo Branch"),
    PlaceCategory(id: 4, name: "Study Areas", icon: "desk", iconColor: .cyan, location: "Colombo Branch"),
    PlaceCategory(id: 5, name: "Office", icon: "briefcase", iconColor: .purple, location: "Colombo Branch"),
    PlaceCategory(id: 6, name: "Cafeteria", icon: "fork.knife", iconColor: .green, location: "Colombo Branch")
]


let lectureHalls = [
    PlacesData(
        id: 1,
        name: "Lecture Hall 01",
        isAvailable: true,
        color: .red,
        floor: "Ground floor",
        crowdLevel: "80-100",
        category: "Lecture Hall",
        description: "Lecture Hall 1 is a spacious, air-conditioned hall equipped with modern multimedia facilities, ideal for large group lectures and presentations.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_1_2", "lecture_hall_1_3"],
        capacity: 100,
        features: ["Air Conditioning", "Multimedia System", "Comfortable Seating"]
    ),
    PlacesData(
        id: 2,
        name: "Lecture Hall 02",
        isAvailable: true,
        color: .blue,
        floor: "Ground floor",
        crowdLevel: "60-80",
        category: "Lecture Hall",
        description: "Modern lecture hall with excellent acoustics and visual presentation capabilities. Perfect for medium-sized classes and seminars.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "lecture_hall_2",
        galleryImages: ["lecture_hall_2_2", "lecture_hall_2_3"],
        capacity: 80,
        features: ["Sound System", "Interactive Whiteboard", "Recording Equipment"]
    ),
    PlacesData(
        id: 3,
        name: "Lecture Hall 03",
        isAvailable: false,
        color: .purple,
        floor: "Ground floor",
        crowdLevel: "100-120",
        category: "Lecture Hall",
        description: "Large capacity lecture hall designed for major presentations and conferences. Currently under maintenance.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: false),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: false)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_3_2", "lecture_hall_3_3"],
        capacity: 120,
        features: ["Large Screen", "Tiered Seating", "Conference Setup"]
    ),
    PlacesData(
        id: 4,
        name: "Lecture Hall 04",
        isAvailable: true,
        color: .orange,
        floor: "First floor",
        crowdLevel: "40-60",
        category: "Lecture Hall",
        description: "Intimate lecture hall perfect for small group discussions and interactive sessions. Features modern technology integration.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_4_2", "lecture_hall_4_3"],
        capacity: 60,
        features: ["Interactive Display", "Flexible Seating", "Video Conferencing"]
    ),
    PlacesData(
        id: 5,
        name: "Lecture Hall 05",
        isAvailable: true,
        color: .green,
        floor: "First floor",
        crowdLevel: "80-100",
        category: "Lecture Hall",
        description: "State-of-the-art lecture hall with advanced multimedia capabilities and comfortable ergonomic seating for extended sessions.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_5_2", "lecture_hall_5_3"],
        capacity: 100,
        features: ["Smart Board", "Surround Sound", "Climate Control"]
    ),
    PlacesData(
        id: 6,
        name: "Lecture Hall 06",
        isAvailable: true,
        color: .cyan,
        floor: "First floor",
        crowdLevel: "50-70",
        category: "Lecture Hall",
        description: "Versatile lecture space with movable furniture and multiple presentation zones. Ideal for collaborative learning environments.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_6_2", "lecture_hall_6_3"],
        capacity: 70,
        features: ["Flexible Layout", "Multiple Screens", "Wireless Presentation"]
    ),
    PlacesData(
        id: 7,
        name: "Lecture Hall 07",
        isAvailable: false,
        color: .red,
        floor: "Second floor",
        crowdLevel: "60-80",
        category: "Lecture Hall",
        description: "Premium lecture hall with theater-style seating and professional lighting. Currently being upgraded with new technology.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: false),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: false)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_7_2", "lecture_hall_7_3"],
        capacity: 80,
        features: ["Theater Seating", "Professional Lighting", "High-End Audio"]
    ),
    PlacesData(
        id: 8,
        name: "Lecture Hall 08",
        isAvailable: true,
        color: .yellow,
        floor: "Second floor",
        crowdLevel: "90-110",
        category: "Lecture Hall",
        description: "Large capacity hall with excellent sightlines and acoustics. Features the latest in presentation technology and student comfort.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_8_2", "lecture_hall_8_3"],
        capacity: 110,
        features: ["Stadium Seating", "4K Projection", "Advanced Audio System"]
    ),
    PlacesData(
        id: 9,
        name: "Lecture Hall 09",
        isAvailable: true,
        color: .pink,
        floor: "Second floor",
        crowdLevel: "70-90",
        category: "Lecture Hall",
        description: "Modern lecture hall designed for interactive learning with breakout spaces and collaborative technology integration.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "lecture_hall_1",
        galleryImages: ["lecture_hall_9_2", "lecture_hall_9_3"],
        capacity: 90,
        features: ["Breakout Spaces", "Collaborative Tech", "Modern Design"]
    )
]


let labs = [
    PlacesData(
        id: 10,
        name: "Computer Lab 01",
        isAvailable: true,
        color: .red,
        floor: "Second floor",
        crowdLevel: "30-40",
        category: "Computer Lab",
        description: "State-of-the-art computer lab equipped with latest hardware and software for programming, web development, and digital design courses.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "computer_lab_1",
        galleryImages: ["computer_lab_1_2", "computer_lab_1_3"],
        capacity: 40,
        features: ["High-Speed Internet", "Latest Software", "Individual Workstations"]
    ),
    PlacesData(
        id: 11,
        name: "Computer Lab 02",
        isAvailable: true,
        color: .blue,
        floor: "Second floor",
        crowdLevel: "25-35",
        category: "Computer Lab",
        description: "Advanced programming lab with specialized software for software engineering and database management courses.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Projector", icon: "tv", isAvailable: true)
        ],
        mainImage: "computer_lab_2",
        galleryImages: ["computer_lab_2_2", "computer_lab_2_3"],
        capacity: 35,
        features: ["Development Tools", "Database Software", "Version Control"]
    ),
    PlacesData(
        id: 12,
        name: "Computer lab 04",
        isAvailable: true,
        color: .green,
        floor: "Third floor",
        crowdLevel: "20-30",
        category: "Computer Lab",
        description: "Fully equipped Computer laboratory for IOS, , graphic  experiments with modern safety equipment.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Safety", icon: "shield.fill", isAvailable: true)
        ],
        mainImage: "computer_lab_1",
        galleryImages: ["science_lab_1_2", "science_lab_1_3"],
        capacity: 30,
        features: ["Safety Equipment", "Modern Instruments", "Chemical Storage"]
    ),
    PlacesData(
        id: 13,
        name: "Computer Lab 04",
        isAvailable: false,
        color: .orange,
        floor: "Fourth floor",
        crowdLevel: "20-25",
        category: "Computer Lab",
        description: "Fully equipped Computer laboratory for IOS, , graphic  experiments with modern safety equipment.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: false),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "3D Printer", icon: "cube.fill", isAvailable: false)
        ],
        mainImage: "computer_lab_1",
        galleryImages: ["engineering_lab_2", "engineering_lab_3"],
        capacity: 25,
        features: ["CAD Software", "3D Printing", "Design Tools"]
    )
]

let libraries = [
    PlacesData(
        id: 14,
        name: "Main Library",
        isAvailable: true,
        color: .purple,
        floor: "Second floor",
        crowdLevel: "100-150",
        category: "Library",
        description: "Comprehensive library with extensive collection of books, journals, and digital resources. Quiet study environment with modern facilities.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Computers", icon: "desktopcomputer", isAvailable: true),
            Facility(name: "Printer", icon: "printer.fill", isAvailable: true)
        ],
        mainImage: "library_main",
        galleryImages: ["library_main_2", "library_main_3"],
        capacity: 150,
        features: ["Silent Study Area", "Group Study Rooms", "Digital Resources"]
    )
]

let studyAreas = [
    PlacesData(
        id: 15,
        name: "Study Area 01",
        isAvailable: true,
        color: .cyan,
        floor: "First floor",
        crowdLevel: "40-50",
        category: "Study Area",
        description: "Open study area with comfortable seating and natural lighting. Perfect for individual study and small group discussions.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Lighting", icon: "lightbulb.fill", isAvailable: true)
        ],
        mainImage: "study_area_1",
        galleryImages: ["study_area_1_2", "study_area_1_3"],
        capacity: 50,
        features: ["Natural Light", "Comfortable Seating", "Quiet Environment"]
    ),
    PlacesData(
        id: 16,
        name: "Study Area 02",
        isAvailable: true,
        color: .mint,
        floor: "Second floor",
        crowdLevel: "30-40",
        category: "Study Area",
        description: "Premium study area with individual study pods and group collaboration spaces. Equipped with modern amenities.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Power", icon: "bolt.fill", isAvailable: true),
            Facility(name: "Lockers", icon: "lock.fill", isAvailable: true)
        ],
        mainImage: "study_area_1",
        galleryImages: ["study_area_2_2", "study_area_2_3"],
        capacity: 40,
        features: ["Study Pods", "Group Tables", "Storage Lockers"]
    )
]


let offices = [
    PlacesData(
        id: 17,
        name: "Administration Office",
        isAvailable: true,
        color: .indigo,
        floor: "First floor",
        crowdLevel: "5-10",
        category: "Administrative Office",
        description: "Main administrative office handling student services, admissions, and general inquiries. Professional staff available during business hours.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Printer", icon: "printer.fill", isAvailable: true),
            Facility(name: "Phone", icon: "phone.fill", isAvailable: true)
        ],
        mainImage: "admin_office",
        galleryImages: ["admin_office_2", "admin_office_3"],
        capacity: 10,
        features: ["Student Services", "Document Processing", "Information Desk"]
    ),
    PlacesData(
        id: 18,
        name: "Software Engineering Office",
        isAvailable: true,
        color: .teal,
        floor: "Second floor",
        crowdLevel: "10-15",
        category: "Faculty Office",
        description: "Faculty office space for academic staff consultations, meetings, and administrative work. Available for student consultations by appointment.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Computer", icon: "desktopcomputer", isAvailable: true),
            Facility(name: "Meeting Room", icon: "person.3.fill", isAvailable: true)
        ],
        mainImage: "admin_office",
        galleryImages: ["faculty_office_2", "faculty_office_3"],
        capacity: 15,
        features: ["Private Offices", "Meeting Rooms", "Consultation Areas"]
    ),
    PlacesData(
        id: 19,
        name: "Business Study  Office",
        isAvailable: true,
        color: .brown,
        floor: "Third floor",
        crowdLevel: "5-8",
        category: "Technical Office",
        description: "IT support and technical services office. Provides technical assistance, equipment maintenance, and system support for the campus.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Servers", icon: "server.rack", isAvailable: true),
            Facility(name: "Tools", icon: "wrench.and.screwdriver.fill", isAvailable: true)
        ],
        mainImage: "admin_office",
        galleryImages: ["it_office_2", "it_office_3"],
        capacity: 8,
        features: ["Technical Support", "Equipment Repair", "Network Management"]
    )
]


let cafeterias = [
    PlacesData(
        id: 20,
        name: "Main Cafeteria",
        isAvailable: true,
        color: .pink,
        floor: "Ground floor",
        crowdLevel: "150-200",
        category: "Cafeteria",
        description: "Spacious cafeteria offering a variety of local and international cuisine. Clean, comfortable dining environment with affordable prices for students and staff.",
        facilities: [
            Facility(name: "WiFi", icon: "wifi", isAvailable: true),
            Facility(name: "AC", icon: "snowflake", isAvailable: true),
            Facility(name: "Microwave", icon: "microwave.fill", isAvailable: true),
            Facility(name: "Water", icon: "drop.fill", isAvailable: true)
        ],
        mainImage: "cafeteria_main",
        galleryImages: ["cafeteria_main_2", "cafeteria_main_3"],
        capacity: 200,
        features: ["Multiple Food Counters", "Seating Areas", "Takeaway Service"]
    )
]


let allPlaces = lectureHalls + labs + libraries + studyAreas + offices + cafeterias


func getPlacesByCategory(_ category: String) -> [PlacesData] {
    return allPlaces.filter { $0.category.contains(category) }
}

func getAvailablePlaces() -> [PlacesData] {
    return allPlaces.filter { $0.isAvailable }
}

func getPlacesByFloor(_ floor: String) -> [PlacesData] {
    return allPlaces.filter { $0.floor == floor }
}
