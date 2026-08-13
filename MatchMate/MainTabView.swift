import SwiftUI

struct MainTabView: View {

    @Environment(AppState.self)
    private var appState

    var body: some View {
        TabView {

            DiscoveryView()
                .tabItem {
                    Label(
                        "Discover",
                        systemImage: "heart.fill"
                    )
                }

            MatchesView(
                matches: appState.matches
            )
            .tabItem {
                Label(
                    "Matches",
                    systemImage: "message.fill"
                )
            }

            ProfileView()
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "person.fill"
                    )
                }
        }
    }
}