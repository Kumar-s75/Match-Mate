import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.blue)

                Text("My Profile")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Complete your profile to get better matches.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button("Edit Profile") {
                    print("Edit profile")
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding(.top, 40)
            .navigationTitle("Profile")
        }
    }
}