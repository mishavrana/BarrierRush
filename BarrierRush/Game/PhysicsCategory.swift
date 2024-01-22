import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all : UInt32 = UInt32.max
    static let cone: UInt32 = 0b1
    static let car : UInt32 = 0b10
}
