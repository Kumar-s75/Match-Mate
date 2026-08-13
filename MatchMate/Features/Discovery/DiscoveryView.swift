import SwiftUI

struct DiscoveryView: View {

    @StateObject private var viewModel = DiscoveryViewModel()

    var body: some View {

        NavigationStack {

            VStack(spacing: 12) {

                // MARK: - Main Content

                if viewModel.isLoading {

                    loadingView

                } else if let errorMessage = viewModel.errorMessage {

                    errorView(message: errorMessage)

                } else {

                    cardStack

                }

                // MARK: - Action Buttons

                if !viewModel.isLoading &&
                    viewModel.errorMessage == nil &&
                    viewModel.hasMoreProfiles {

                    actionButtons
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 8)
            .navigationTitle("Discover")

            // MARK: - Load Profiles

            .task {
                viewModel.loadProfiles()
            }

            // MARK: - Match Alert

            .alert(
                "It's a Match! 🎉",
                isPresented: $viewModel.showMatch
            ) {

                Button("Keep Discovering") {
                    viewModel.showMatch = false
                }

            } message: {

                if let profile = viewModel.matchedProfile {

                    Text(
                        "You and \(profile.name) liked each other!"
                    )
                }
            }
        }
    }

    // MARK: - Card Stack

    private var cardStack: some View {

        ZStack {

            // Next profile underneath

            if let profile = viewModel.nextProfile {

                ProfileCardView(
                    profile: profile
                )
                .scaleEffect(0.94)
                .offset(y: 10)
            }

            // Current profile

            if let profile = viewModel.currentProfile {

                ZStack {

                    ProfileCardView(
                        profile: profile
                    )

                    swipeIndicator
                }
                .offset(
                    viewModel.dragOffset
                )
                .rotationEffect(
                    .degrees(
                        Double(
                            viewModel.dragOffset.width / 20
                        )
                    )
                )
                .gesture(

                    DragGesture()

                        .onChanged { value in

                            viewModel.dragOffset =
                                value.translation
                        }

                        .onEnded { value in

                            viewModel.handleSwipe(
                                value.translation
                            )
                        }
                )

            } else {

                emptyState
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }

    // MARK: - Loading View

    private var loadingView: some View {

        VStack(spacing: 18) {

            ProgressView()
                .scaleEffect(1.4)

            Text("Finding matches...")
                .font(.headline)

            Text(
                "Looking for people who might be a good match for you."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }

    // MARK: - Error View

    private func errorView(
        message: String
    ) -> some View {

        VStack(spacing: 18) {

            Image(
                systemName: "exclamationmark.triangle"
            )
            .font(
                .system(size: 50)
            )
            .foregroundStyle(.orange)

            Text("Something went wrong")
                .font(.title3)
                .fontWeight(.bold)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Try Again") {

                viewModel.loadProfiles()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }

    // MARK: - Swipe Indicators

    private var swipeIndicator: some View {

        ZStack {

            // LIKE

            if viewModel.dragOffset.width > 20 {

                Text("LIKE")
                    .font(
                        .system(
                            size: 34,
                            weight: .heavy
                        )
                    )
                    .foregroundStyle(.green)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .overlay(

                        RoundedRectangle(
                            cornerRadius: 12
                        )
                        .stroke(
                            .green,
                            lineWidth: 4
                        )
                    )
                    .rotationEffect(
                        .degrees(-15)
                    )
                    .opacity(
                        min(
                            Double(
                                viewModel.dragOffset.width / 120
                            ),
                            1
                        )
                    )
                    .position(
                        x: 100,
                        y: 80
                    )
            }

            // PASS

            if viewModel.dragOffset.width < -20 {

                Text("PASS")
                    .font(
                        .system(
                            size: 34,
                            weight: .heavy
                        )
                    )
                    .foregroundStyle(.red)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .overlay(

                        RoundedRectangle(
                            cornerRadius: 12
                        )
                        .stroke(
                            .red,
                            lineWidth: 4
                        )
                    )
                    .rotationEffect(
                        .degrees(15)
                    )
                    .opacity(
                        min(
                            Double(
                                abs(
                                    viewModel.dragOffset.width
                                ) / 120
                            ),
                            1
                        )
                    )
                    .position(
                        x: 270,
                        y: 80
                    )
            }
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {

        HStack(spacing: 45) {

            // PASS BUTTON

            Button {

                viewModel.pass()

            } label: {

                Image(
                    systemName: "xmark"
                )
                .font(
                    .system(
                        size: 24,
                        weight: .bold
                    )
                )
                .foregroundStyle(.red)
                .frame(
                    width: 68,
                    height: 68
                )
                .background(.white)
                .clipShape(Circle())
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 6
                )
            }

            // LIKE BUTTON

            Button {

                viewModel.like()

            } label: {

                Image(
                    systemName: "heart.fill"
                )
                .font(
                    .system(
                        size: 28,
                        weight: .bold
                    )
                )
                .foregroundStyle(.pink)
                .frame(
                    width: 76,
                    height: 76
                )
                .background(.white)
                .clipShape(Circle())
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 6
                )
            }
        }
        .padding(.vertical, 8)
    }

    // MARK: - Empty State

    private var emptyState: some View {

        VStack(spacing: 18) {

            Image(
                systemName: "sparkles"
            )
            .font(
                .system(size: 60)
            )
            .foregroundStyle(.purple)

            Text("You've seen everyone!")
                .font(.title2)
                .fontWeight(.bold)

            Text(
                "Check back later for new matches."
            )
            .foregroundStyle(.secondary)

            Button("Start Over") {

                viewModel.reset()
            }
            .buttonStyle(
                .borderedProminent
            )
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}