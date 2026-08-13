import Foundation
import SwiftUI

@MainActor
final class DiscoveryViewModel: ObservableObject {

    @Published private(set) var profiles: [UserProfile] = []

    @Published private(set) var currentIndex = 0

    @Published var dragOffset: CGSize = .zero

    @Published var showMatch = false

    @Published var matchedProfile: UserProfile?

    @Published var isLoading = false

    @Published var errorMessage: String?

    private let repository:
        ProfileRepositoryProtocol

    let swipeThreshold: CGFloat = 120

    init(
        repository: ProfileRepositoryProtocol =
            ProfileRepository()
    ) {
        self.repository = repository
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

    // MARK: - More Profiles

    var hasMoreProfiles: Bool {
        currentIndex < profiles.count
    }

    // MARK: - Load Profiles

    func loadProfiles() {

        isLoading = true
        errorMessage = nil

        Task {

            do {

                let loadedProfiles =
                    try await repository.fetchProfiles()

                profiles = loadedProfiles
                currentIndex = 0

            } catch {

                errorMessage =
                    "Unable to load profiles."

            }

            isLoading = false
        }
    }

    // MARK: - Swipe

    func handleSwipe(
        _ translation: CGSize
    ) {

        if translation.width > swipeThreshold {

            like()

        } else if translation.width <
                    -swipeThreshold {

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

        withAnimation(.easeIn(duration: 0.3)) {

            dragOffset = CGSize(
                width: 800,
                height: 0
            )
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.3
        ) {

            self.currentIndex += 1
            self.dragOffset = .zero

            if profile.compatibility >= 90 {

                self.matchedProfile =
                    profile

                self.showMatch = true
            }
        }
    }

    // MARK: - Pass

    func pass() {

        guard currentProfile != nil else {
            return
        }

        withAnimation(.easeIn(duration: 0.3)) {

            dragOffset = CGSize(
                width: -800,
                height: 0
            )
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.3
        ) {

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
}