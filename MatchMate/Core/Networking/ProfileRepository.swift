import Foundation

protocol ProfileRepositoryProtocol {

    func fetchProfiles() async throws -> [UserProfile]
}

final class ProfileRepository: ProfileRepositoryProtocol {

    private let apiService: APIService

    init(
        apiService: APIService = .shared
    ) {
        self.apiService = apiService
    }

    func fetchProfiles() async throws -> [UserProfile] {

        guard let url = URL(
            string: "http://127.0.0.1:8000/api/profiles"
        ) else {
            throw APIError.invalidURL
        }

        return try await apiService.fetch(
            [UserProfile].self,
            from: url
        )
    }
} 