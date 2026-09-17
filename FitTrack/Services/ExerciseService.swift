//
//  ExerciseService.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

import Foundation

final class ExerciseService {

    private let baseURL = "https://oss.exercisedb.dev/api/v1"

    private func makeExercisesURL(
        after cursor: String? = nil,
        name: String? = nil,
        bodyPart: String? = nil,
        muscle: String? = nil,
        equipment: String? = nil
    ) throws -> URL {

        guard var components = URLComponents(string: "\(baseURL)/exercises")
        else {
            throw NetworkError.invalidURL
        }

        var queryItems = [
            URLQueryItem(name: "limit", value: "25")
        ]

        if let cursor {
            queryItems.append(URLQueryItem(name: "after", value: cursor))
        }

        if let name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }

        if let bodyPart, !bodyPart.isEmpty {
            queryItems.append(URLQueryItem(name: "bodyParts", value: bodyPart))
        }

        if let muscle, !muscle.isEmpty {
            queryItems.append(
                URLQueryItem(name: "targetMuscles", value: muscle)
            )
        }

        if let equipment, !equipment.isEmpty {
            queryItems.append(
                URLQueryItem(name: "equipments", value: equipment)
            )
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        return url
    }

    private func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    func fetchExercises(
        after cursor: String? = nil,
        name: String? = nil,
        bodyPart: String? = nil,
        muscle: String? = nil,
        equipment: String? = nil
    )
        async throws -> ExerciseResponse
    {

        let url = try makeExercisesURL(
            after: cursor,
            name: name,
            bodyPart: bodyPart,
            muscle: muscle,
            equipment: equipment
        )

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

            return response
        } catch {
            throw NetworkError.decodingFailed
        }
    }

}
