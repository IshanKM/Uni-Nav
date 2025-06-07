import SwiftUI

struct ChatView: View {
    @StateObject private var userProfile = UserProfileManager()
    
    var body: some View {
        if userProfile.isProfileComplete {
            GlobalChatView()
                .environmentObject(userProfile)
        } else {
            ChatDetailsView()
                .environmentObject(userProfile)
        }
    }
}

