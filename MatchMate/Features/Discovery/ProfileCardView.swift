import SwiftUI

struct ProfileCardView: View {
    let profile: UserProfile

    var body: some View {
        VStack(spacing: 0) {

            // Profile image
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.7),
                                Color.purple.opacity(0.7)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: profile.imageSystemName)
                    .font(.system(size: 110))
                    .foregroundStyle(.white.opacity(0.9))
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)

                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 24))

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text(profile.location)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(20)
            }

            VStack(alignment: .leading, spacing: 14) {

                HStack {
                    Text("\(profile.compatibility)% Match")
                        .font(.headline)
                        .foregroundStyle(.green)

                    Spacer()

                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                }

                Text(profile.bio)
                    .font(.body)
                    .foregroundStyle(.secondary)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(profile.interests, id: \.self) { interest in
                            Text(interest)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 7)
                                .background(.thinMaterial)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding(20)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8)
    }
}