import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)
            
            ChatView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "message.fill" : "message")
                    Text("Chat")
                }
                .tag(1)
            
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

struct HomeView: View {
    @State private var selectedAnnouncementTab = "Announcement"
    @State private var selectedEventTab = "Event"

    private let userBatch = "23.1P Batch"
    
    private var todaysLectures: [TimetableItem] {
        return timetableItems.filter { item in
            item.batch == userBatch
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    HStack {
                        HStack(spacing: 8) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Hi, S.G.I.K !")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Text("👋")
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: NotificationView()) {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    Spacer()
                    
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
                 
                       
                        if userBatch.isEmpty {
                           
                            LoginPromptCard()
                        } else if todaysLectures.isEmpty {
                           
                            VStack(spacing: 12) {
                                Image(systemName: "calendar.badge.exclamationmark")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.6))
                                
                                Text("No lectures scheduled for today")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text("Batch: \(userBatch)")
                                    .font(.caption)
                                    .foregroundColor(.gray.opacity(0.8))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal, 20)
                        } else {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(todaysLectures, id: \.subject) { lecture in
                                        NavigationLink(destination: CampusMapView()) {
                                            TimetableCard(item: lecture)
                                                .frame(width: 350)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 10),
                        GridItem(.flexible(), spacing: 10)
                    ], spacing: 15) {
                        NavigationLink(destination: PlacesView()) {
                            NavigationCard(title: "Places", imageName: "places_logo")
                        }
                        NavigationLink(destination: BacktoYouView()) {
                            NavigationCard(title: "BackToYou", imageName: "backtoyou_logo")
                        }
                        NavigationLink(destination: CampusMapView()) {
                            NavigationCard(title: "Campus Map", imageName: "map_logo")
                        }
                        NavigationLink(destination: AcademicStaffView()) {
                            NavigationCard(title: "Academic Staff", imageName: "acedemicStuff")
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                    
                    
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

struct AnnouncementCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Exam Alert")
                    .font(.headline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("june 4")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text("Web Api Development Exam time added. please check lms for more details.")
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

struct EventsContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("2025 Career Fair")
                    .font(.headline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("June 05")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text("Join this 1st saturday in NIBM premises for valuable opportunities. please contact program office for more info.")
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





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
