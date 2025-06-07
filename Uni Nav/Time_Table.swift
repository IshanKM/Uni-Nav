
import SwiftUI

struct TimetableListView: View {
    @Environment(\.presentationMode) var presentationMode
    

    let timetableItems = [
        TimetableItem(
            subject: "Web API Development",
            time: "09:00 - 11:00  and 12:00 - 3:30",
            location: "Lecture Hall 01",
            batch: "23.1 Batch"
        ),
        TimetableItem(
            subject: "Agile Development",
            time: "09:00 - 11:00  and 12:00 - 3:30",
            location: "Lecture Hall 02",
            batch: "23.2 Batch"
        ),
        TimetableItem(
            subject: "iOS App Development",
            time: "09:00 - 11:00  and 12:00 - 3:30",
            location: "Lab 01",
            batch: "24.1 Batch"
        ),
        TimetableItem(
            subject: "Design for usability",
            time: "09:00 - 11:00  and 12:00 - 3:30",
            location: "Horizon Hall",
            batch: ""
        ),
        TimetableItem(
            subject: "Design for usability",
            time: "09:00 - 11:00  and 12:00 - 3:30",
            location: "Horizon Hall",
            batch: ""
        )
    ]
    
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
                
                Text("Today's TimeTable")
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
                    ForEach(timetableItems, id: \.subject) { item in
                        TimetableCard(item: item)
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


struct TimetableItem {
    let subject: String
    let time: String
    let location: String
    let batch: String
}


struct TimetableCard: View {
    let item: TimetableItem
    
    var body: some View {
        Button(action: {
      
        }) {
            VStack(alignment: .leading, spacing: 12) {
                Text(item.subject)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Text(item.time)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Text(item.location)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                if !item.batch.isEmpty {
                    HStack {
                        Image(systemName: "person.2")
                            .foregroundColor(.gray)
                            .font(.caption)
                        Text(item.batch)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}


struct TimetableListView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableListView()
    }
}
