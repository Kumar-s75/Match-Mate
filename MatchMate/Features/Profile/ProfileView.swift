import SwiftUI

struct ProfileView: View {

    var body: some View {
        NavigationStack {
            Form {

                Section {
                    HStack {
                        Spacer()

                        VStack(spacing: 10) {

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
                                .frame(
                                    width: 100,
                                    height: 100
                                )
                                .overlay {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 40))
                                        .foregroundStyle(.white)
                                }

                            Text("Kumar")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Software Engineer")
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                    .padding(.vertical)
                }

                Section("About") {
                    LabeledContent(
                        "Location",
                        value: "India"
                    )

                    LabeledContent(
                        "Interests",
                        value: "Technology, Travel"
                    )
                }

                Section("Preferences") {
                    NavigationLink("Discovery Preferences") {
                        Text("Preferences")
                            .navigationTitle("Preferences")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}