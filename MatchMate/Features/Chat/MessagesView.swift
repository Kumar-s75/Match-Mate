import SwiftUI

struct MessagesView: View {

    var body: some View {

        NavigationStack {

            ContentUnavailableView(
                "No Messages",
                systemImage: "message.circle",
                description: Text(
                    "Start chatting when you get a match."
                )
            )

            .navigationTitle("Messages")
        }
    }
}