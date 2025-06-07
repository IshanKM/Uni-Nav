import SwiftUI

struct ChatDetailsView: View {
    @EnvironmentObject var userProfile: UserProfileManager
    @State private var selectedAvatarIndex: Int = 0
    @State private var selectedBatch: String = "23.1P"
    @State private var whatsappNumber: String = ""
    @State private var showingBatchPicker = false
    
    let avatars = ["⚡", "⚡"]
    let batches = ["23.1P", "23.2P", "24.1P", "24.2P", "25.1P"]
    
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
            
            VStack(alignment: .leading, spacing: 30) {
                Spacer()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Select your avatar")
                        .font(.headline)
                        .padding(.horizontal, 20)
                    
                    HStack(spacing: 20) {
                        ForEach(0..<avatars.count, id: \.self) { index in
                            Button(action: {
                                selectedAvatarIndex = index
                            }) {
                                Text(avatars[index])
                                    .font(.system(size: 40))
                                    .frame(width: 70, height: 70)
                                    .background(
                                        Circle()
                                            .fill(Color.orange.opacity(0.2))
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(selectedAvatarIndex == index ? Color.blue : Color.clear, lineWidth: 3)
                                    )
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                

                VStack(alignment: .leading, spacing: 12) {
                    Text("Please select your batch")
                        .font(.headline)
                        .padding(.horizontal, 20)
                    
                    Button(action: {
                        showingBatchPicker = true
                    }) {
                        HStack {
                            Text(selectedBatch)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Enter Your Whatsapp Number (optional)")
                        .font(.headline)
                        .padding(.horizontal, 20)
                    
                    TextField("Enter Here", text: $whatsappNumber)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                
                Button(action: {
                    userProfile.saveProfile(
                        avatar: avatars[selectedAvatarIndex],
                        batch: selectedBatch,
                        whatsapp: whatsappNumber
                    )
                }) {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
        }
        .actionSheet(isPresented: $showingBatchPicker) {
            ActionSheet(
                title: Text("Select Batch"),
                buttons: batches.map { batch in
                    .default(Text(batch)) {
                        selectedBatch = batch
                    }
                } + [.cancel()]
            )
        }
    }
}

struct ChatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailsView()
    }
}
