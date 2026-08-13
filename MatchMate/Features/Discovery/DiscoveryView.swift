import SwiftUI

struct DiscoveryView: View {

    // MARK: - Demo Profiles

    private let profiles: [UserProfile] = [

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

    // MARK: - State

    @State private var currentIndex = 0

    @State private var dragOffset: CGSize = .zero

    @State private var showMatch = false

    @State private var matchedProfile: UserProfile?

    private let swipeThreshold: CGFloat = 120

    // MARK: - Body

    var body: some View {

        NavigationStack {

            VStack(spacing: 12) {

                // MARK: Card Area

                ZStack {

                    // Next card underneath
                    if currentIndex + 1 < profiles.count {

                        ProfileCardView(
                            profile: profiles[currentIndex + 1]
                        )
                        .scaleEffect(0.94)
                        .offset(y: 10)
                    }

                    // Current card
                    if currentIndex < profiles.count {

                        ZStack {

                            ProfileCardView(
                                profile: profiles[currentIndex]
                            )

                            // MARK: LIKE Indicator

                            if dragOffset.width > 20 {

                                Text("LIKE")
                                    .font(
                                        .system(
                                            size: 34,
                                            weight: .heavy
                                        )
                                    )
                                    .foregroundStyle(.green)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 8)
                                    .overlay(
                                        RoundedRectangle(
                                            cornerRadius: 12
                                        )
                                        .stroke(
                                            .green,
                                            lineWidth: 4
                                        )
                                    )
                                    .rotationEffect(
                                        .degrees(-15)
                                    )
                                    .opacity(
                                        min(
                                            Double(
                                                dragOffset.width / 120
                                            ),
                                            1
                                        )
                                    )
                                    .position(
                                        x: 100,
                                        y: 80
                                    )
                            }

                            // MARK: PASS Indicator

                            if dragOffset.width < -20 {

                                Text("PASS")
                                    .font(
                                        .system(
                                            size: 34,
                                            weight: .heavy
                                        )
                                    )
                                    .foregroundStyle(.red)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 8)
                                    .overlay(
                                        RoundedRectangle(
                                            cornerRadius: 12
                                        )
                                        .stroke(
                                            .red,
                                            lineWidth: 4
                                        )
                                    )
                                    .rotationEffect(
                                        .degrees(15)
                                    )
                                    .opacity(
                                        min(
                                            Double(
                                                abs(
                                                    dragOffset.width
                                                ) / 120
                                            ),
                                            1
                                        )
                                    )
                                    .position(
                                        x: 270,
                                        y: 80
                                    )
                            }
                        }
                        .offset(dragOffset)
                        .rotationEffect(
                            .degrees(
                                Double(
                                    dragOffset.width / 20
                                )
                            )
                        )
                        .gesture(

                            DragGesture()

                                .onChanged { value in

                                    dragOffset =
                                        value.translation
                                }

                                .onEnded { value in

                                    handleSwipe(
                                        value.translation
                                    )
                                }
                        )

                    } else {

                        emptyState
                    }
                }

                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )

                // MARK: Action Buttons

                if currentIndex < profiles.count {

                    actionButtons
                        .padding(.bottom, 8)
                }
            }

            .padding(.horizontal, 12)
            .padding(.top, 8)

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

                    Text(
                        "You and \(matchedProfile.name) liked each other!"
                    )
                }
            }
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {

        HStack(spacing: 45) {

            // PASS

            Button {

                swipeLeft()

            } label: {

                Image(systemName: "xmark")
                    .font(
                        .system(
                            size: 24,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.red)
                    .frame(
                        width: 68,
                        height: 68
                    )
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(
                        color: .black.opacity(0.15),
                        radius: 6
                    )
            }

            // LIKE

            Button {

                swipeRight()

            } label: {

                Image(systemName: "heart.fill")
                    .font(
                        .system(
                            size: 28,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.pink)
                    .frame(
                        width: 76,
                        height: 76
                    )
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(
                        color: .black.opacity(0.15),
                        radius: 6
                    )
            }
        }
        .padding(.vertical, 8)
    }

    // MARK: - Empty State

    private var emptyState: some View {

        VStack(spacing: 16) {

            Image(systemName: "sparkles")
                .font(
                    .system(size: 60)
                )
                .foregroundStyle(.purple)

            Text("You've seen everyone!")
                .font(.title2)
                .fontWeight(.bold)

            Text(
                "Check back later for new matches."
            )
            .foregroundStyle(.secondary)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }

    // MARK: - Swipe Handling

    private func handleSwipe(
        _ translation: CGSize
    ) {

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

    // MARK: - Swipe Right

    private func swipeRight() {

        guard currentIndex < profiles.count else {
            return
        }

        let profile =
            profiles[currentIndex]

        withAnimation(
            .easeIn(duration: 0.35)
        ) {

            dragOffset = CGSize(
                width: 800,
                height: 0
            )
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.35
        ) {

            currentIndex += 1

            dragOffset = .zero

            // Temporary demo match logic
            if profile.compatibility >= 90 {

                matchedProfile =
                    profile

                showMatch = true
            }
        }
    }

    // MARK: - Swipe Left

    private func swipeLeft() {

        guard currentIndex < profiles.count else {
            return
        }

        withAnimation(
            .easeIn(duration: 0.35)
        ) {

            dragOffset = CGSize(
                width: -800,
                height: 0
            )
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.35
        ) {

            currentIndex += 1

            dragOffset = .zero
        }
    }
}