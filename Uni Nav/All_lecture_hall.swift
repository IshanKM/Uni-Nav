
import SwiftUI

struct LectureHallsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""

    let lectureHalls = [
        LectureHall(
            id: 1,
            name: "Lecture Halls 01",
            isAvailable: true,
            color: .red
        ),
        LectureHall(
            id: 2,
            name: "Lecture Halls 02",
            isAvailable: true,
            color: .blue
        ),
        LectureHall(
            id: 3,
            name: "Lecture Halls 03",
            isAvailable: false,
            color: .purple
        ),
        LectureHall(
            id: 4,
            name: "Lecture Halls 04",
            isAvailable: true,
            color: .orange
        ),
        LectureHall(
            id: 5,
            name: "Lecture Halls 05",
            isAvailable: true,
            color: .green
        ),
        LectureHall(
            id: 6,
            name: "Lecture Halls 06",
            isAvailable: true,
            color: .cyan
        ),
        LectureHall(
            id: 7,
            name: "Lecture Halls 07",
            isAvailable: false,
            color: .red
        ),
        LectureHall(
            id: 8,
            name: "Lecture Halls 08",
            isAvailable: true,
            color: .yellow
        ),
        LectureHall(
            id: 9,
            name: "Lecture Halls 09",
            isAvailable: true,
            color: .pink
        )
    ]
    
    var filteredHalls: [LectureHall] {
        if searchText.isEmpty {
            return lectureHalls
        } else {
            return lectureHalls.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
   
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
                
                Text("Lecture Halls")
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
            

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredHalls, id: \.id) { hall in
                        LectureHallRow(hall: hall)
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


struct LectureHall: Identifiable {
    let id: Int
    let name: String
    let isAvailable: Bool
    let color: Color
}

struct LectureHallRow: View {
    let hall: LectureHall
    @State private var showDetails = false
    
    var body: some View {
        Button(action: {
            showDetails = true
        }) {
            HStack(spacing: 16) {
     
                Circle()
                    .fill(hall.color)
                    .frame(width: 10, height: 10)
                
  
                Text(hall.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                Spacer()
                
  
                Text(hall.isAvailable ? "Available" : "Not Available")
                    .font(.caption)
                    .foregroundColor(hall.isAvailable ? .green : .red)

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
            LectureHallDetailView(hall: hall)
        }
    }
}

struct LectureHallDetailView: View {
    let hall: LectureHall
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
  
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
                
                Text(hall.name)
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
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Status")
                                .font(.headline)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Text(hall.isAvailable ? "Available" : "Not Available")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(hall.isAvailable ? .green : .red)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(hall.isAvailable ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                                .cornerRadius(20)
                        }
                        
                        Divider()
                        
    
                        VStack(spacing: 12) {
                            DetailsRow(icon: "location", title: "Location", value: "Main Building, Floor 2")
                            DetailsRow(icon: "person.2", title: "Capacity", value: "120 Students")
                            DetailsRow(icon: "desktopcomputer", title: "Equipment", value: "Projector, Sound System")
                            DetailsRow(icon: "clock", title: "Available Hours", value: "8:00 AM - 6:00 PM")
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
      
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Today's Schedule")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        if hall.isAvailable {
                            Text("No classes scheduled at this time")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 20)
                        } else {
                            VStack(spacing: 12) {
                                ScheduleRow(time: "09:00 - 11:00", subject: "Web API Development", batch: "23.1 Batch")
                                
                                Divider()
                                
                                ScheduleRow(time: "12:00 - 3:30", subject: "iOS App Development", batch: "24.1 Batch")
                            }
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                    

                    if hall.isAvailable {
                        Button(action: {
                           
                        }) {
                            Text("Book This Hall")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top, 8)
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


struct ScheduleRow: View {
    let time: String
    let subject: String
    let batch: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(time)
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack {
                Text(subject)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text(batch)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}


struct PlaceCardContent: View {
    let place: PlaceItem
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
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

struct LabsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Labs")
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("Labs information coming soon...")
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

struct LibrariesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Libraries")
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("Libraries information coming soon...")
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

struct OfficeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Office")
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("Office information coming soon...")
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

struct CafeteriaView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Cafeteria")
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("Cafeteria information coming soon...")
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

struct LectureHallsView_Previews: PreviewProvider {
    static var previews: some View {
        LectureHallsView()
    }
}
