
import SwiftUI

struct TimetableListView: View {
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




struct TimetableListView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableListView()
    }
}
