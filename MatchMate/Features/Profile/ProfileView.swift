import SwiftUI

struct ProfileView: View {

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 20) {

                    Image(
                        systemName:
                            "person.crop.circle.fill"
                    )
                    .font(
                        .system(size: 110)
                    )
                    .foregroundStyle(.purple)

                    Text("Kumar")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Software Engineer")
                        .foregroundStyle(.secondary)

                    Divider()

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        Text("About Me")
                            .font(.headline)

                        Text(
                            "Building software, exploring technology and meeting interesting people."
                        )
                        .foregroundStyle(.secondary)
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        Text("Interests")
                            .font(.headline)

                        HStack {

                            InterestTag(
                                title: "Technology"
                            )

                            InterestTag(
                                title: "Travel"
                            )

                            InterestTag(
                                title: "Music"
                            )
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                    Button("Edit Profile") {

                        print(
                            "Edit profile tapped"
                        )
                    }
                    .buttonStyle(
                        .borderedProminent
                    )
                }
                .padding()
            }

            .navigationTitle("Profile")
        }
    }
}

// MARK: - Interest Tag

struct InterestTag: View {

    let title: String

    var body: some View {

        Text(title)
            .font(.caption)
            .fontWeight(.medium)
            .padding(
                .horizontal,
                10
            )
            .padding(
                .vertical,
                7
            )
            .background(
                .purple.opacity(0.1)
            )
            .clipShape(
                Capsule()
            )
    }
}