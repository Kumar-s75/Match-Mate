import SwiftUI

@main
struct MatchMateApp: App {

    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(appState)
        }
    }
}