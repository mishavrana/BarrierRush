import Foundation
import UIKit
import Network

final class AuthService {
    static let shared = AuthService()
    let connectionMonitor = NWPathMonitor()
    
    private init() { }
    
    public func checkAuthorisation() async -> Bool {
        let vendorId = await UIDevice.current.identifierForVendor?.uuidString
        guard NetworkCheck.shared.isConnected else { return false }
        guard let vendorId else { return false }
        
        
        do {
            let existingIdentifier = try await FirebaseManager.shared.db.document("users/\(vendorId)").getDocument()
            return existingIdentifier.exists
            
        } catch {
            NSLog("\(error.localizedDescription)")
            return false
        }
    }
    
    func regeisterDevice() async throws {
        guard NetworkCheck.shared.isConnected else { throw CustomError.noConnection }
        guard let vendorId =
                await UIDevice.current.identifierForVendor?.uuidString
        else { throw CustomError.invalidRegistration }
        
        try await FirebaseManager.shared.db.collection("users").document(vendorId).setData([
            "id" : vendorId
        ])
    }
}
