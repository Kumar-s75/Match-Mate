import SwiftUI

struct MatchesView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No Matches Yet",
                systemImage: "heart.circle",
                description: Text("Your matches will appear here.")
            )
            .navigationTitle("Matches")
        }
    }
}