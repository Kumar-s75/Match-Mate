import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case networkError(Error)
}

final class APIService {

    static let shared = APIService()

    private let session: URLSession

    private init() {
        self.session = URLSession.shared
    }

    func fetch<T: Decodable>(
        _ type: T.Type,
        from url: URL
    ) async throws -> T {

        do {
            let (data, response) = try await session.data(
                from: url
            )

            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw APIError.invalidResponse
            }

            do {
                return try JSONDecoder().decode(
                    T.self,
                    from: data
                )
            } catch {
                throw APIError.decodingFailed
            }

        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
}