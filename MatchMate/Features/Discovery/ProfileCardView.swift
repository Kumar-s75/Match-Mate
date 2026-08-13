import SwiftUI

struct ProfileCardView: View {

    let profile: UserProfile

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Profile Image

            ZStack(alignment: .topTrailing) {

                LinearGradient(
                    colors: [
                        .purple,
                        .blue
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Image(systemName: profile.imageSystemName)
                    .font(.system(size: 110))
                    .foregroundStyle(.white.opacity(0.9))
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)

                // Compatibility badge
                Text("\(profile.compatibility)% Match")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(.black.opacity(0.45))
                    .clipShape(Capsule())
                    .padding(14)
            }
            .frame(height: 230)

            // MARK: - Profile Information

            VStack(alignment: .leading, spacing: 10) {

                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(profile.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("\(profile.age)")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .foregroundStyle(.secondary)

                    Text(profile.location)
                        .foregroundStyle(.secondary)
                }

                Text(profile.bio)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                // MARK: - Interests

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(profile.interests, id: \.self) { interest in
                            Text(interest)
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.gray.opacity(0.12))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding(16)
        }
        .background(Color(.systemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
        .frame(maxWidth: .infinity)
        .shadow(
            color: .black.opacity(0.15),
            radius: 10,
            x: 0,
            y: 5
        )
    }
}