import SwiftUI

struct MatchesView: View {
    let matches: [Match]

    var body: some View {
        NavigationStack {
            Group {
                if matches.isEmpty {
                    EmptyMatchesView()
                } else {
                    List(matches) { match in
                        MatchRow(match: match)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Matches")
        }
    }
}

// MARK: - Match Row

struct MatchRow: View {
    let match: Match

    var body: some View {
        HStack(spacing: 15) {

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            .purple,
                            .blue
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 60, height: 60)
                .overlay {
                    Text(
                        String(
                            match.profile.name.prefix(1)
                        )
                    )
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 5) {
                Text(
                    "\(match.profile.name), \(match.profile.age)"
                )
                .font(.headline)

                Text(
                    match.profile.location
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Text("You matched!")
                    .font(.caption)
                    .foregroundStyle(.green)
            }

            Spacer()

            Image(systemName: "message.fill")
                .foregroundStyle(.blue)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Empty State

struct EmptyMatchesView: View {
    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "heart.circle")
                .font(.system(size: 70))
                .foregroundStyle(.pink)

            Text("No Matches Yet")
                .font(.title2)
                .fontWeight(.bold)

            Text(
                "Keep discovering people. Your next match could be one swipe away."
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    MatchesView(matches: [])
}