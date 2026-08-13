import SwiftUI

struct MatchesView: View {

    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No Matches Yet",
                systemImage: "heart.circle",
                description: Text(
                    "Keep discovering people to find your match."
                )
            )
            .navigationTitle("Matches")
        }
    }
}