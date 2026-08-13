import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {

            DiscoveryView()
                .tabItem {
                    Label(
                        "Discover",
                        systemImage: "sparkles"
                    )
                }

            MatchesView()
                .tabItem {
                    Label(
                        "Matches",
                        systemImage: "heart.fill"
                    )
                }

            MessagesView()
                .tabItem {
                    Label(
                        "Messages",
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