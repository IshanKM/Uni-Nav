import SwiftUI

struct GlobalChatView: View {
    @EnvironmentObject var userProfile: UserProfileManager
    @State private var messageText = ""
    @State private var onlyMyBatch = false
    @State private var showingWhatsAppAlert = false
    @State private var selectedUserWhatsApp = ""
    
    let sampleMessages = [
        ("⚡", "is there anyone in 24.1 batch ?", false, "+1234567890"),
        ("⚡", "yes", true, ""),
        ("⚡", "is it ok if i contact you ?", false, "+1234567890")
    ]
    
    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                Color.blue
                    .ignoresSafeArea(edges: .top)
                
                Text("Chat with Colleagues")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(height: 100)
            
            HStack {
                HStack {
                    Button(action: {
                        onlyMyBatch.toggle()
                    }) {
                        Image(systemName: onlyMyBatch ? "checkmark.square" : "square")
                            .foregroundColor(.blue)
                    }
                    
                    Text("Only for your batch")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {
                    userProfile.resetProfile()
                }) {
                    Text("Change Details")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.gray.opacity(0.05))
            

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<sampleMessages.count, id: \.self) { index in
                        let message = sampleMessages[index]
                        
                        HStack(alignment: .top, spacing: 12) {
                            if !message.2 {
                                Button(action: {
                                    if !message.3.isEmpty {
                                        selectedUserWhatsApp = message.3
                                        showingWhatsAppAlert = true
                                    }
                                }) {
                                    Text(message.0)
                                        .font(.title2)
                                        .frame(width: 40, height: 40)
                                        .background(
                                            Circle()
                                                .fill(Color.orange.opacity(0.2))
                                        )
                                }
                            }
                            
                            VStack(alignment: message.2 ? .trailing : .leading) {
                                Text(message.1)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(message.2 ? Color.blue : Color.gray.opacity(0.1))
                                    )
                                    .foregroundColor(message.2 ? .white : .black)
                            }
                            
                            if message.2 {
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: message.2 ? .trailing : .leading)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
            
            Spacer()
            

            HStack {
                TextField("Type a reply...", text: $messageText)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                Button(action: {

                    messageText = ""
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .alert("Contact User", isPresented: $showingWhatsAppAlert) {
            Button("Chat on WhatsApp") {
                openWhatsApp(number: selectedUserWhatsApp)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Would you like to chat on WhatsApp?")
        }
    }
    
    private func openWhatsApp(number: String) {
        let urlString = "https://wa.me/\(number)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}


struct GlobalChatView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalChatView()
    }
}
