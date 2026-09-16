//
//  ExercisesViewModel.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

import Foundation

final class ExercisesViewModel {

    private let exerciseService = ExerciseService()

    private var exercises: [Exercise] = []

    var numberOfExercises: Int {
        exercises.count
    }

    func exercise(at index: Int) -> Exercise {
        exercises[index]
    }

    func fetchExercises() async throws {
        let fetchExercises = try await exerciseService.fetchExercises()
        exercises = fetchExercises
    }
}
