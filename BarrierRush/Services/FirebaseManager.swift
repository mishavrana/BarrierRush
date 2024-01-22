import Foundation
import FirebaseFirestore


final class FirebaseManager {
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    private init() { }
}
