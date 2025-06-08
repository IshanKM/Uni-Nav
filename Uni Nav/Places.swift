import SwiftUI

struct PlacesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let places = placesCategories

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

                Text("Places")
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

     
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(places, id: \.id) { place in
                        NavigationLink(destination: PlaceListView(categoryName: place.name)) {
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
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 100)
            }
            .background(Color.gray.opacity(0.05))
        }
        .navigationBarHidden(true)
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlacesView()
        }
    }
}
