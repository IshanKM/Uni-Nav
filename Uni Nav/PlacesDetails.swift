import SwiftUI

struct PlaceDetailView: View {
    let place: PlacesData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                ZStack(alignment: .topLeading) {
   
                    Image(place.mainImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                        .overlay(
             
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
     
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(12)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 3)
                    }
                    .padding(.top, 50)
                    .padding(.leading, 20)
                }
                
   
                VStack(alignment: .leading, spacing: 24) {

                    VStack(alignment: .leading, spacing: 16) {
                        Text(place.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
      
                        HStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Flow")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(place.floor)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Crowd Level")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(place.crowdLevel)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                            

                            HStack {
                                Circle()
                                    .fill(place.isAvailable ? Color.green : Color.red)
                                    .frame(width: 12, height: 12)
                                Text(place.isAvailable ? "Available" : "Unavailable")
                                    .font(.caption)
                                    .foregroundColor(place.isAvailable ? .green : .red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Category")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(place.category)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                    

                    VStack(alignment: .leading, spacing: 8) {
                        Text(place.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                    }
                    

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Facilities")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 0) {
                            ForEach(place.facilities) { facility in
                                VStack(spacing: 8) {
                                    Image(systemName: facility.icon)
                                        .font(.title2)
                                        .foregroundColor(facility.isAvailable ? .blue : .gray)
                                        .frame(height: 30)
                                    
                                    Text(facility.name)
                                        .font(.caption)
                                        .foregroundColor(facility.isAvailable ? .black : .gray)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                .opacity(facility.isAvailable ? 1.0 : 0.5)
                            }
                        }
                    }
                    
 
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Gallery")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(place.galleryImages, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(8)
                                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.horizontal, -20)
                    }
                    
  
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Additional Information")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            DetailInfoRow(label: "Capacity", value: "\(place.capacity) people")
                            DetailInfoRow(label: "Floor", value: place.floor)
                            DetailInfoRow(label: "Category", value: place.category)
                            
                            if !place.features.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Features")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    ForEach(place.features, id: \.self) { feature in
                                        HStack(spacing: 8) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.green)
                                                .font(.caption)
                                            Text(feature)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                        .padding(16)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(12)
                    }
                    
                }
                .padding(20)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct DetailInfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}
