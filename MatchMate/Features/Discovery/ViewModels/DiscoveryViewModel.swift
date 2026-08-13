import Foundation
import SwiftUI

@MainActor
final class DiscoveryViewModel: ObservableObject {

    @Published private(set) var profiles: [UserProfile] = []

    @Published private(set) var currentIndex: Int = 0

    @Published var dragOffset: CGSize = .zero

    @Published var showMatch = false

    @Published var matchedProfile: UserProfile?

    let swipeThreshold: CGFloat = 120

    init() {
        profiles = Self.mockProfiles
    }

    // MARK: - Current Profile

    var currentProfile: UserProfile? {
        guard currentIndex < profiles.count else {
            return nil
        }

        return profiles[currentIndex]
    }

    // MARK: - Next Profile

    var nextProfile: UserProfile? {
        guard currentIndex + 1 < profiles.count else {
            return nil
        }

        return profiles[currentIndex + 1]
    }

    // MARK: - Has More Profiles

    var hasMoreProfiles: Bool {
        currentIndex < profiles.count
    }

    // MARK: - Handle Swipe

    func handleSwipe(_ translation: CGSize) {

        if translation.width > swipeThreshold {
            like()
        } else if translation.width < -swipeThreshold {
            pass()
        } else {
            withAnimation(.spring()) {
                dragOffset = .zero
            }
        }
    }

    // MARK: - Like

    func like() {

        guard let profile = currentProfile else {
            return
        }

        withAnimation(.easeIn(duration: 0.35)) {
            dragOffset = CGSize(
                width: 800,
                height: 0
            )
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {

            self.currentIndex += 1
            self.dragOffset = .zero

            // Temporary demo matching logic.
            // This will later come from the backend.
            if profile.compatibility >= 90 {
                self.matchedProfile = profile
                self.showMatch = true
            }
        }
    }

    // MARK: - Pass

    func pass() {

        guard currentProfile != nil else {
            return
        }

        withAnimation(.easeIn(duration: 0.35)) {
            dragOffset = CGSize(
                width: -800,
                height: 0
            )
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {

            self.currentIndex += 1
            self.dragOffset = .zero
        }
    }

    // MARK: - Reset

    func reset() {

        currentIndex = 0
        dragOffset = .zero
        showMatch = false
        matchedProfile = nil
    }

    // MARK: - Mock Data

    private static let mockProfiles: [UserProfile] = [

        UserProfile(
            name: "Priya",
            age: 24,
            location: "Delhi",
            bio: "Love travelling, photography and discovering new places.",
            interests: [
                "Travel",
                "Photography",
                "Music"
            ],
            compatibility: 92,
            imageSystemName: "person.crop.circle.fill"
        ),

        UserProfile(
            name: "Ananya",
            age: 23,
            location: "Mumbai",
            bio: "Coffee enthusiast who enjoys books, movies and weekend trips.",
            interests: [
                "Coffee",
                "Books",
                "Movies"
            ],
            compatibility: 87,
            imageSystemName: "person.crop.circle.fill"
        ),

        UserProfile(
            name: "Riya",
            age: 23,
            location: "Bangalore",
            bio: "Software engineer, foodie and occasional trekker.",
            interests: [
                "Technology",
                "Food",
                "Trekking"
            ],
            compatibility: 84,
            imageSystemName: "person.crop.circle.fill"
        ),

        UserProfile(
            name: "Sneha",
            age: 24,
            location: "Pune",
            bio: "Designer who loves art, hiking and exploring new cafes.",
            interests: [
                "Design",
                "Hiking",
                "Food"
            ],
            compatibility: 81,
            imageSystemName: "person.crop.circle.fill"
        )
    ]
}