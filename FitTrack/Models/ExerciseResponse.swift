//
//  Exercise.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

struct ExerciseResponse: Decodable {
    let success: Bool
    let meta: Meta
    let data: [Exercise]
}

struct Meta: Decodable {
    let total: Int
    let hasNextPage: Bool
    let hasPreviousPage: Bool
    let nextCursor: String?
    let previousCursor: String?
}
