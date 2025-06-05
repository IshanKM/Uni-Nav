// MainTabView.swift
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)
            
            // Chat Tab
            ChatView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "message.fill" : "message")
                    Text("Chat")
                }
                .tag(1)
            
            // Account Tab
            AccountView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                    Text("Account")
                }
                .tag(2)
        }
        .accentColor(.blue)
    }
}

// DashboardView.swift (Home Tab Content)
struct HomeView: View {
    @State private var selectedAnnouncementTab = "Announcement"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        HStack(spacing: 8) {
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                                .font(.title2)
                            
                            Text("Hi, S.G.I.K !")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Text("👋")
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle notifications
                        }) {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Today's Timetable
                    VStack(spacing: 16) {
                        HStack {
                            Text("Today's TimeTable")
                                .font(.headline)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            NavigationLink(destination: TimetableListView()) {
                                        Text("All")
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                    }
                        }
                        .padding(.horizontal, 20)
                        
                        // Timetable Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Web API Development")
                                .font(.headline)
                                .fontWeight(.medium)
                            
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                Text("09:00 - 11:00  and 12:00 - 3:30")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Image(systemName: "location")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                Text("Lecture Hall 01")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Image(systemName: "person.2")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                Text("23.1 Batch")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 20)
                    }
                    
                    // Navigation Cards Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 10),
                        GridItem(.flexible(), spacing: 10)
                    ], spacing: 15) {
                        NavigationLink(destination: PlacesView()) {
                            NavigationCard(title: "Places", imageName: "chemistry_lab")
                        }
                        NavigationLink(destination: PlacesView()) {
                            NavigationCard(title: "BackToYou", imageName: "chemistry_lab")
                        }
                        NavigationLink(destination: PlacesView()) {
                            NavigationCard(title: "Places", imageName: "chemistry_lab")
                        }
                        NavigationLink(destination: PlacesView()) {
                            NavigationCard(title: "Places", imageName: "chemistry_lab")
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Announcement/Events Section
                    VStack(spacing: 16) {
                        HStack(spacing: 40) {
                            TabButton(
                                title: "Announcement",
                                isSelected: selectedAnnouncementTab == "Announcement"
                            ) {
                                selectedAnnouncementTab = "Announcement"
                            }
                            
                            TabButton(
                                title: "Events",
                                isSelected: selectedAnnouncementTab == "Events"
                            ) {
                                selectedAnnouncementTab = "Events"
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        // Content based on selected tab
                        if selectedAnnouncementTab == "Announcement" {
                            AnnouncementCard()
                        } else {
                            EventsContent()
                        }
                    }
                    
                    Spacer(minLength: 100)
                }
            }
            .background(Color.gray.opacity(0.05))
        }
        .navigationBarHidden(true)
    }
}

struct NavigationCard: View {
    let title: String
    let imageName: String

    var body: some View {
        VStack(spacing: 12) {
            // Image or background
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.red.opacity(0.6)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 100)
                .overlay(
                    ZStack {
                        Circle().fill(Color.white.opacity(0.3)).frame(width: 20, height: 20).offset(x: -20, y: -15)
                        Circle().fill(Color.white.opacity(0.4)).frame(width: 15, height: 15).offset(x: 15, y: -20)
                        Circle().fill(Color.white.opacity(0.3)).frame(width: 18, height: 18).offset(x: 10, y: 15)
                        Circle().fill(Color.white.opacity(0.6)).frame(width: 30, height: 30).blur(radius: 10)
                    }
                )

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


// TabButton Component
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
                    .foregroundColor(isSelected ? .purple : .gray)
                
                if isSelected {
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: 60, height: 2)
                        .cornerRadius(1)
                }
            }
        }
    }
}

// AnnouncementCard Component
struct AnnouncementCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("FBISE")
                    .font(.headline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("May 01")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text("The Federal Board of Intermediate and Secondary Education (FBISE) has officially announced the date for the results of the Secondary School Certificate (SSC) Part I & II 1st Annual Examinations.")
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(nil)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 20)
    }
}

// EventsContent Component
struct EventsContent: View {
    var body: some View {
        VStack {
            Text("No events available")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(40)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 20)
    }
}

// ChatView Component
struct ChatView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Chat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Chat functionality coming soon...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Chat")
        }
    }
}

// AccountView Component
struct AccountView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Section
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
                
                // Account Options
                VStack(spacing: 0) {
                    AccountRow(icon: "person.circle", title: "Profile Settings")
                    AccountRow(icon: "bell", title: "Notifications")
                    AccountRow(icon: "lock", title: "Privacy & Security")
                    AccountRow(icon: "questionmark.circle", title: "Help & Support")
                    AccountRow(icon: "rectangle.portrait.and.arrow.right", title: "Logout", isDestructive: true)
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Account")
        }
    }
}

// AccountRow Component
struct AccountRow: View {
    let icon: String
    let title: String
    var isDestructive: Bool = false
    
    var body: some View {
        Button(action: {
            // Handle row tap
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



// Notification Extension
extension Notification.Name {
    static let loginSuccess = Notification.Name("loginSuccess")
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

