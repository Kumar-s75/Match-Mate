//
//  DiscoveryView.swift
//  MatchMate
//
//  Created by Kumar Saurabh on 13/08/26.
//

import SwiftUI

struct DiscoveryView: View {
    @State private var profiles: [UserProfile] = [
        UserProfile(
            name: "Riya",
            age: 23,
            location: "Bangalore",
            bio: "Music lover, traveler and occasional photographer.",
            interests: ["Music", "Travel", "Photography"],
            compatibility: 84
        ),
        UserProfile(
            name: "Ananya",
            age: 24,
            location: "Mumbai",
            bio: "Coffee addict, developer and weekend explorer.",
            interests: ["Coffee", "Coding", "Travel"],
            compatibility: 91
        ),
        UserProfile(
            name: "Meera",
            age: 22,
            location: "Delhi",
            bio: "Bookworm who loves art, food and discovering new places.",
            interests: ["Books", "Art", "Food"],
            compatibility: 78
        )
    ]

    @State private var offset: CGSize = .zero
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // Header
                HStack {
                    Text("Discover")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Spacer()

                    Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .padding(.top)

                // Cards
                ZStack {
                    if profiles.isEmpty {
                        EmptyStateView()
                    } else {
                        ForEach(profiles.indices.reversed(), id: \.self) { index in
                            ProfileCardView(profile: profiles[index])
                                .offset(
                                    index == profiles.count - 1
                                    ? offset
                                    : .zero
                                )
                                .rotationEffect(
                                    .degrees(
                                        index == profiles.count - 1
                                        ? rotation
                                        : 0
                                    )
                                )
                                .scaleEffect(
                                    index == profiles.count - 1
                                    ? 1
                                    : 0.95
                                )
                                .gesture(
                                    index == profiles.count - 1
                                    ? dragGesture
                                    : nil
                                )
                                .animation(
                                    .spring(),
                                    value: offset
                                )
                        }
                    }
                }
                .padding(.horizontal)

                // Action buttons
                HStack(spacing: 35) {

                    ActionButton(
                        icon: "xmark",
                        size: 60
                    ) {
                        swipeLeft()
                    }

                    ActionButton(
                        icon: "heart.fill",
                        size: 70
                    ) {
                        swipeRight()
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }

    // MARK: - Swipe Gesture

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = value.translation

                rotation = Double(
                    value.translation.width / 20
                )
            }
            .onEnded { value in

                let horizontalMovement =
                    value.translation.width

                if horizontalMovement > 120 {
                    swipeRight()
                } else if horizontalMovement < -120 {
                    swipeLeft()
                } else {
                    withAnimation(.spring()) {
                        offset = .zero
                        rotation = 0
                    }
                }
            }
    }

    // MARK: - Swipe Actions

    private func swipeRight() {
        guard !profiles.isEmpty else { return }

        withAnimation(.easeIn(duration: 0.3)) {
            offset = CGSize(width: 500, height: 0)
            rotation = 20
        }

        removeTopCard()
    }

    private func swipeLeft() {
        guard !profiles.isEmpty else { return }

        withAnimation(.easeIn(duration: 0.3)) {
            offset = CGSize(width: -500, height: 0)
            rotation = -20
        }

        removeTopCard()
    }

    private func removeTopCard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            profiles.removeLast()
            offset = .zero
            rotation = 0
        }
    }
}

// MARK: - Action Button

struct ActionButton: View {
    let icon: String
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

// MARK: - Empty State

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.2.slash")
                .font(.system(size: 50))
                .foregroundStyle(.gray)

            Text("No more profiles")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)

            Text("Check back later for new matches.")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    DiscoveryView()
}