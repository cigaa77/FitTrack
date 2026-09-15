//
//  ExerciseService.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

import Foundation

final class ExerciseService {

    private let baseURL = "https://oss.exercisedb.dev/api/v1"

    private func makeExercisesURL() throws -> URL {
        guard let url = URL(string: "\(baseURL)/exercises") else {
            throw NetworkError.invalidURL
        }

        return url
    }

    private func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    func fetchExercises() async throws -> [Exercise] {
        let url = try makeExercisesURL()
        let request = makeRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode
        }
        do {
            let response = try JSONDecoder().decode(
                ExerciseResponse.self,
                from: data
            )

            return response.data
        } catch {
            throw NetworkError.decodingFailed
        }
    }

}
