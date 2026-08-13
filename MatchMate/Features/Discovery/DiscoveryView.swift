import SwiftUI

struct DiscoveryView: View {

    private let profiles: [UserProfile] = [
        UserProfile(
            name: "Priya",
            age: 24,
            location: "Delhi",
            bio: "Love travelling, photography and discovering new places.",
            interests: ["Travel", "Photography", "Music"],
            compatibility: 92,
            imageSystemName: "person.crop.circle.fill"
        ),

        UserProfile(
            name: "Ananya",
            age: 23,
            location: "Mumbai",
            bio: "Coffee enthusiast who enjoys books, movies and weekend trips.",
            interests: ["Coffee", "Books", "Movies"],
            compatibility: 87,
            imageSystemName: "person.crop.circle.fill"
        ),

        UserProfile(
            name: "Riya",
            age: 25,
            location: "Bangalore",
            bio: "Software engineer, foodie and occasional trekker.",
            interests: ["Technology", "Food", "Trekking"],
            compatibility: 84,
            imageSystemName: "person.crop.circle.fill"
        ),

        UserProfile(
            name: "Sneha",
            age: 24,
            location: "Pune",
            bio: "Designer who loves art, hiking and exploring new cafes.",
            interests: ["Design", "Hiking", "Food"],
            compatibility: 81,
            imageSystemName: "person.crop.circle.fill"
        )
    ]

    @State private var currentIndex = 0
    @State private var dragOffset: CGSize = .zero
    @State private var showMatch = false
    @State private var matchedProfile: UserProfile?

    private let swipeThreshold: CGFloat = 120

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                ZStack {
                    if currentIndex + 1 < profiles.count {
                        ProfileCardView(profile: profiles[currentIndex + 1])
                            .scaleEffect(0.94)
                            .offset(y: 8)
                    }

                    if currentIndex < profiles.count {
                        ProfileCardView(profile: profiles[currentIndex])
                            .offset(dragOffset)
                            .rotationEffect(
                                .degrees(Double(dragOffset.width / 20))
                            )
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation
                                    }
                                    .onEnded { value in
                                        handleSwipe(value.translation)
                                    }
                            )
                    } else {
                        emptyState
                    }
                }
                .padding(.horizontal)

                if currentIndex < profiles.count {
                    actionButtons
                }

                Spacer()
            }
            .padding(.top)
            .navigationTitle("Discover")
            .alert(
                "It's a Match! 🎉",
                isPresented: $showMatch
            ) {
                Button("Keep Discovering") {
                    showMatch = false
                }
            } message: {
                if let matchedProfile {
                    Text("You and \(matchedProfile.name) liked each other!")
                }
            }
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        HStack(spacing: 40) {

            Button {
                swipeLeft()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2.bold())
                    .foregroundStyle(.red)
                    .frame(width: 64, height: 64)
                    .background(.thinMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }

            Button {
                swipeRight()
            } label: {
                Image(systemName: "heart.fill")
                    .font(.title2.bold())
                    .foregroundStyle(.pink)
                    .frame(width: 64, height: 64)
                    .background(.thinMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 60))
                .foregroundStyle(.purple)

            Text("You've seen everyone!")
                .font(.title2)
                .fontWeight(.bold)

            Text("Check back later for new matches.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 450)
    }

    // MARK: - Swipe Handling

    private func handleSwipe(_ translation: CGSize) {

        if translation.width > swipeThreshold {
            swipeRight()
        } else if translation.width < -swipeThreshold {
            swipeLeft()
        } else {
            withAnimation(.spring()) {
                dragOffset = .zero
            }
        }
    }

    private func swipeRight() {

        guard currentIndex < profiles.count else {
            return
        }

        let profile = profiles[currentIndex]

        withAnimation(.easeIn(duration: 0.25)) {
            dragOffset = CGSize(width: 600, height: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            matchedProfile = profile
            currentIndex += 1
            dragOffset = .zero

            // Demo match logic.
            // Later this will come from the backend.
            if profile.compatibility >= 90 {
                showMatch = true
            }
        }
    }

    private func swipeLeft() {

        guard currentIndex < profiles.count else {
            return
        }

        withAnimation(.easeIn(duration: 0.25)) {
            dragOffset = CGSize(width: -600, height: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            currentIndex += 1
            dragOffset = .zero
        }
    }
}