import Foundation

protocol ProfileRepositoryProtocol {

    func fetchProfiles() async throws
        -> [UserProfile]
}

final class ProfileRepository:
    ProfileRepositoryProtocol {

    private let apiService: APIService

    init(
        apiService: APIService = .shared
    ) {
        self.apiService = apiService
    }

    func fetchProfiles() async throws
        -> [UserProfile] {

        // Temporary mock implementation.
        //
        // This will later become:
        //
        // let url = ...
        // return try await apiService.fetch(
        //     [UserProfile].self,
        //     from: url
        // )

        return [
            UserProfile(
                name: "Priya",
                age: 24,
                location: "Delhi",
                bio: "Love travelling, photography and discovering new places.",
                interests: [
                    "Travel",
                    "Photography",
                    "Music"
                ],
                compatibility: 92,
                imageSystemName:
                    "person.crop.circle.fill"
            ),

            UserProfile(
                name: "Ananya",
                age: 23,
                location: "Mumbai",
                bio: "Coffee enthusiast who enjoys books, movies and weekend trips.",
                interests: [
                    "Coffee",
                    "Books",
                    "Movies"
                ],
                compatibility: 87,
                imageSystemName:
                    "person.crop.circle.fill"
            ),

            UserProfile(
                name: "Riya",
                age: 23,
                location: "Bangalore",
                bio: "Software engineer, foodie and occasional trekker.",
                interests: [
                    "Technology",
                    "Food",
                    "Trekking"
                ],
                compatibility: 84,
                imageSystemName:
                    "person.crop.circle.fill"
            ),

            UserProfile(
                name: "Sneha",
                age: 24,
                location: "Pune",
                bio: "Designer who loves art, hiking and exploring new cafes.",
                interests: [
                    "Design",
                    "Hiking",
                    "Food"
                ],
                compatibility: 81,
                imageSystemName:
                    "person.crop.circle.fill"
            )
        ]
    }
}