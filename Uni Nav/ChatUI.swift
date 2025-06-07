import SwiftUI


struct ChatApp: App {
    @StateObject private var userProfile = UserProfileManager()
    
    var body: some Scene {
        WindowGroup {
            ChatCheck()
                .environmentObject(userProfile)
        }
    }
}

struct ChatCheck: View {
    var body: some View {
        MainTabView()
    }
}
