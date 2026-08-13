import Foundation

struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let location: String
    let bio: String
    let interests: [String]
    let compatibility: Int
    let imageSystemName: String
}