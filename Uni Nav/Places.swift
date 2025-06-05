import SwiftUI

// MARK: - Main Places View
struct PlacesView: View {
    @Environment(\.presentationMode) var presentationMode

    // Sample places data
    let places = [
        PlaceItem(icon: "building.2", iconColor: .blue, name: "Lecture Halls", location: "Colombo Branch"),
        PlaceItem(icon: "flask", iconColor: .red, name: "Labs", location: "Colombo Branch"),
        PlaceItem(icon: "book", iconColor: .yellow, name: "Libraries", location: "Colombo Branch"),
        PlaceItem(icon: "desk", iconColor: .cyan, name: "Study Areas", location: "Colombo Branch"),
        PlaceItem(icon: "briefcase", iconColor: .purple, name: "Office", location: "Colombo Branch"),
        PlaceItem(icon: "fork.knife", iconColor: .green, name: "Cafeteria", location: "Colombo Branch")
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Custom Header
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

                Text("Places")
                    .font(.headline)
                    .fontWeight(.medium)

                Spacer()

                // Invisible button for balance
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.clear)
                        .font(.title2)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color.white)

            // Places List
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(places, id: \.name) { place in
                        PlaceCard(place: place)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 100) // Extra padding for tab bar
            }
            .background(Color.gray.opacity(0.05))
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Place Data Model
struct PlaceItem {
    let icon: String
    let iconColor: Color
    let name: String
    let location: String
}

// MARK: - Place Card View with Navigation
struct PlaceCard: View {
    let place: PlaceItem

    @ViewBuilder
    var destinationView: some View {
        switch place.name {
        case "Lecture Halls":
            LectureHallsView()
        case "Labs":
            LabsView()
        case "Libraries":
            LibrariesView()
        //case "Study Areas":
           // StudyAreasView()
        case "Office":
            OfficeView()
        case "Cafeteria":
            CafeteriaView()
        default:
            Text("Coming Soon...")
        }
    }

    var body: some View {
        NavigationLink(destination: destinationView) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(place.iconColor.opacity(0.1))
                        .frame(width: 40, height: 40)

                    Image(systemName: place.icon)
                        .foregroundColor(place.iconColor)
                        .font(.title3)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(place.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)

                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.gray)
                            .font(.caption)
                        Text(place.location)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}



// MARK: - Preview
struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlacesView()
        }
    }
}
