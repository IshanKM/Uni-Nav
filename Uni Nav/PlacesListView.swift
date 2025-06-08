import SwiftUI

struct PlaceListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    let categoryName: String
    
    // Get the appropriate data based on category name
    var placesData: [PlacesData] {
        switch categoryName {
        case "Lecture Halls":
            return lectureHalls
        case "Labs":
            return labs
        case "Libraries":
            return libraries
        case "Study Areas":
            return studyAreas
        case "Office":
            return offices
        case "Cafeteria":
            return cafeterias
        default:
            return []
        }
    }
    
    // Filter places based on search text
    var filteredPlaces: [PlacesData] {
        if searchText.isEmpty {
            return placesData
        } else {
            return placesData.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
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
                
                Text(categoryName)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.clear)
                        .font(.title2)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color.white)
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search...", text: $searchText)
                    .font(.subheadline)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .background(Color.white)
            
            // Places List
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredPlaces) { place in
                        PlaceRow(place: place)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 100) // Extra padding for tab bar
            }
            .background(Color.gray.opacity(0.05))
        }
        .navigationBarHidden(true)
    }
}

struct PlaceRow: View {
    let place: PlacesData
    @State private var showDetails = false
    
    var body: some View {
        Button(action: {
            showDetails = true
        }) {
            HStack(spacing: 16) {
                // Color dot
                Circle()
                    .fill(place.color)
                    .frame(width: 10, height: 10)
                
                // Name
                Text(place.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                Spacer()
                
                // Availability
                Text(place.isAvailable ? "Available" : "Not Available")
                    .font(.caption)
                    .foregroundColor(place.isAvailable ? .green : .red)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
        }
        .sheet(isPresented: $showDetails) {
            PlaceDetailView(place: place)
        }
    }
}


struct DetailsRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 20)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

