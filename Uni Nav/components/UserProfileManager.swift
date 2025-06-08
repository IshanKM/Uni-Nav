import SwiftUI

class UserProfileManager: ObservableObject {
    @Published var isProfileComplete: Bool = false
    @Published var selectedAvatar: String = ""
    @Published var selectedBatch: String = ""
    @Published var whatsappNumber: String = ""
    
    func saveProfile(avatar: String, batch: String, whatsapp: String) {
        selectedAvatar = avatar
        selectedBatch = batch
        whatsappNumber = whatsapp
        isProfileComplete = true
    }
    
    func resetProfile() {
        isProfileComplete = false
        selectedAvatar = ""
        selectedBatch = ""
        whatsappNumber = ""
    }
}
