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
        VStack(alignment: .leading, spacing: 0) {

            // Profile image placeholder
            ZStack(alignment: .topTrailing) {
                LinearGradient(
                    colors: [
                        Color.purple,
                        Color.blue
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Text("\(profile.compatibility)%")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.green)
                    .clipShape(Capsule())
                    .padding()
            }
            .frame(height: 360)

            // Profile information
            VStack(alignment: .leading, spacing: 10) {

                HStack {
                    Text("\(profile.name), \(profile.age)")
                        .font(.title)
                        .fontWeight(.bold)

                    Spacer()
                }

                Label(
                    profile.location,
                    systemImage: "location.fill"
                )
                .foregroundStyle(.secondary)

                Text(profile.bio)
                    .font(.body)
                    .foregroundStyle(.secondary)

                // Interests
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(profile.interests, id: \.self) { interest in
                            Text(interest)
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 7)
                                .background(Color.gray.opacity(0.15))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding()
            .background(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(
            radius: 15,
            y: 8
        )
    }
}

#Preview {
    ProfileCardView(
        profile: UserProfile(
            name: "Riya",
            age: 23,
            location: "Bangalore",
            bio: "Music lover, traveler and occasional photographer.",
            interests: [
                "Music",
                "Travel",
                "Photography"
            ],
            compatibility: 84
        )
    )
    .padding()
}