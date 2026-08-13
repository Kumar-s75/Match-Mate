//
//  ProfileCardView.swift
//  MatchMate
//
//  Created by Kumar Saurabh on 13/08/26.
//

import SwiftUI

struct ProfileCardView: View {
    let profile: UserProfile

    var body: some View {
        ZStack(alignment: .bottom) {

            RoundedRectangle(cornerRadius: 28)
                .fill(
                    LinearGradient(
                        colors: [
                            .purple.opacity(0.8),
                            .blue.opacity(0.8)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 12) {

                    HStack(alignment: .bottom) {
                        Text("\(profile.name), \(profile.age)")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(.white)

                        Spacer()

                        Text("\(profile.compatibility)%")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(.green.opacity(0.8))
                            .clipShape(Capsule())
                    }

                    Text(profile.location)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))

                    Text(profile.bio)
                        .foregroundStyle(.white.opacity(0.9))
                        .lineLimit(2)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(profile.interests, id: \.self) { interest in
                                Text(interest)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 7)
                                    .background(.white.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                .padding(24)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(radius: 10)
    }
}

#Preview {
    ProfileCardView(
        profile: UserProfile(
            name: "Priya",
            age: 24,
            location: "New Delhi",
            bio: "Love travel, photography and discovering new places.",
            interests: ["Travel", "Photography", "Music"],
            compatibility: 92
        )
    )
    .padding()
}
