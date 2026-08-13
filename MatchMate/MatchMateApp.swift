import SwiftUI

@main
struct MatchMateApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {

            DiscoveryView()
                .tabItem {
                    Label("Discover", systemImage: "sparkles")
                }

            MatchesView()
                .tabItem {
                    Label("Matches", systemImage: "heart.fill")
                }

            MessagesView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}