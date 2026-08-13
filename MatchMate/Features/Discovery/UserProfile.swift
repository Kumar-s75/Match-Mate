import Foundation

struct UserProfile: Identifiable, Codable {

    let id: UUID

    let name: String
    let age: Int
    let location: String
    let bio: String
    let interests: [String]
    let compatibility: Int
    let imageSystemName: String

    init(
        id: UUID = UUID(),
        name: String,
        age: Int,
        location: String,
        bio: String,
        interests: [String],
        compatibility: Int,
        imageSystemName: String
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.location = location
        self.bio = bio
        self.interests = interests
        self.compatibility = compatibility
        self.imageSystemName = imageSystemName
    }
}