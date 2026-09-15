//
//  Exercise.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

struct Exercise: Decodable {
    let exerciseId: String
    let name: String
    let gifUrl: String
    let bodyParts: [String]
    let equipments: [String]
    let targetMuscles: [String]
    let secondaryMuscles: [String]
    let instructions: [String]
}
