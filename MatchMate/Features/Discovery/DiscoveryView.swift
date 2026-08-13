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
            name: "Priya",
            age: 24,
            location: "New Delhi",
            bio: "Love exploring new places, photography and discovering great food.",
            interests: ["Photography", "Travel", "Music"],
            compatibility: 92
        ),

        UserProfile(
            name: "Ananya",
            age: 25,
            location: "Mumbai",
            bio: "Software engineer who enjoys books, coffee and weekend adventures.",
            interests: ["Books", "Coffee", "Coding"],
            compatibility: 87
        ),

        UserProfile(
            name: "Riya",
            age: 23,
            location: "Bangalore",
            bio: "Music lover, traveler and occasional photographer.",
            interests: ["Music", "Travel", "Movies"],
            compatibility: 84
        )
    ]

    @State private var cardOffset: CGSize = .zero

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                if let profile = profiles.last {

                    ProfileCardView(profile: profile)
                        .frame(maxWidth: .infinity)
                        .frame(height: 560)
                        .offset(x: cardOffset.width)
                        .rotationEffect(
                            .degrees(Double(cardOffset.width / 20))
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    cardOffset = value.translation
                                }
                                .onEnded { value in
                                    handleSwipe(value.translation)
                                }
                        )

                } else {

                    VStack(spacing: 16) {
                        Image(systemName: "heart.circle.fill")
                            .font(.system(size: 70))

                        Text("No more profiles")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Check back later for new matches.")
                            .foregroundStyle(.secondary)
                    }
                }

                HStack(spacing: 50) {

                    Button {
                        swipeLeft()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundStyle(.red)
                            .frame(width: 64, height: 64)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }

                    Button {
                        swipeRight()
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundStyle(.pink)
                            .frame(width: 64, height: 64)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
            }
            .padding()
            .navigationTitle("Discover")
            .background(Color(.systemGroupedBackground))
        }
    }

    private func handleSwipe(_ translation: CGSize) {

        let threshold: CGFloat = 120

        if translation.width > threshold {
            swipeRight()
        } else if translation.width < -threshold {
            swipeLeft()
        } else {
            cardOffset = .zero
        }
    }

    private func swipeLeft() {

        withAnimation(.easeIn(duration: 0.25)) {
            cardOffset = CGSize(width: -500, height: 0)
        }

        removeCurrentProfile()
    }

    private func swipeRight() {

        withAnimation(.easeIn(duration: 0.25)) {
            cardOffset = CGSize(width: 500, height: 0)
        }

        removeCurrentProfile()
    }

    private func removeCurrentProfile() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {

            if !profiles.isEmpty {
                profiles.removeLast()
                cardOffset = .zero
            }
        }
    }
}

#Preview {
    DiscoveryView()
}
