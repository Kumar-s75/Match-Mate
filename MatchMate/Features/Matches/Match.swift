
import Foundation

struct Match: Identifiable {
    let id: UUID
    let profile: UserProfile
    let matchedAt: Date

    init(
        id: UUID = UUID(),
        profile: UserProfile,
        matchedAt: Date = Date()
    ) {
        self.id = id
        self.profile = profile
        self.matchedAt = matchedAt
    }
}