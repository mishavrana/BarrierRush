import Foundation

enum CustomError: Error {
    case invalidRegistration
    case noConnection
}

extension CustomError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidRegistration:
            return "Registration for the app was failed"
        case .noConnection:
            return "Check your Internet connection and restart the app"
        }
    }
}
