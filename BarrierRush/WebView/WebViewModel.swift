import Foundation
import UIKit

enum ActiveAlert {
    case basic
    case registrationFalidedAlert
    case registrationSucceedAlert
}

class WebViewModel: ObservableObject {
    
    @Published var isShowingRegistrationAlert = false
    @Published var activeAlert: ActiveAlert = .basic
    
    let firebaseManager = FirebaseManager.shared
    let authService = AuthService.shared
    
    var registrationDeviceError: CustomError?
    
    func regeisterDevice() async {
        do {
            try await authService.regeisterDevice()
            await MainActor.run {
                activeAlert = .registrationSucceedAlert
                isShowingRegistrationAlert = true
            }
        } catch {
            await MainActor.run {
                registrationDeviceError = error as? CustomError
                activeAlert = .registrationFalidedAlert
                isShowingRegistrationAlert = true
            }
            NSLog("\(error.localizedDescription)")
        }
    }
}
