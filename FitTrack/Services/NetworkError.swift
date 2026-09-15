//
//  NetworkError.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case decodingFailed
}
