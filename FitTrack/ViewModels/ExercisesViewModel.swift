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
    private var nextCursor: String?
    private(set) var hasNextPage = true

    private var isLoading = false

    private var currentSearchText: String?

    private(set) var selectedBodyPart: String?
    private(set) var selectedMusclePart: String?
    private(set) var selectedEquipmentPart: String?

    var numberOfExercises: Int {
        exercises.count
    }

    func exercise(at index: Int) -> Exercise? {
        guard exercises.indices.contains(index) else {
            return nil
        }

        return exercises[index]
    }

    func fetchExercises() async throws {
        guard hasNextPage, !isLoading else { return }

        isLoading = true

        defer {
            isLoading = false
        }

        print("----- BEFORE FETCH -----")
        print("Current exercise count:", exercises.count)
        print("Current cursor:", nextCursor ?? "nil")
        print("Body Part:", selectedBodyPart ?? "nil")
        print("Muscle:", selectedMusclePart ?? "nil")
        print("Equipment:", selectedEquipmentPart ?? "nil")

        let response = try await exerciseService.fetchExercises(
            after: nextCursor,
            name: currentSearchText,
            bodyPart: selectedBodyPart,
            muscle: selectedMusclePart,
            equipment: selectedEquipmentPart
        )

        print("----- RESPONSE -----")
        print("Response count:", response.data.count)
        print("New cursor:", response.meta.nextCursor ?? "nil")
        print("Has next page:", response.meta.hasNextPage)

        exercises.append(contentsOf: response.data)

        print("----- AFTER APPEND -----")
        print("Total exercise count:", exercises.count)

        nextCursor = response.meta.nextCursor
        hasNextPage = response.meta.hasNextPage
    }
    func searchExercises(name: String) async throws {

        print("🔴 SEARCH CALLED:", "\"\(name)\"")
        print("🔴 COUNT BEFORE REMOVE:", exercises.count)

        exercises.removeAll()

        print("🔴 COUNT AFTER REMOVE:", exercises.count)
        nextCursor = nil
        hasNextPage = true
        currentSearchText = name

        let response = try await exerciseService.fetchExercises(name: name)

        exercises.append(contentsOf: response.data)
        nextCursor = response.meta.nextCursor
        hasNextPage = response.meta.hasNextPage

    }

    func applyFilters(
        bodyPart: String?,
        musclePart: String?,
        equipmentPart: String?
    ) async throws {

        print("🟠 APPLY FILTER START")
        print("🟠 Body:", bodyPart ?? "nil")
        print("🟠 Muscle:", musclePart ?? "nil")
        print("🟠 Equipment:", equipmentPart ?? "nil")
        print("🟠 Count before request:", exercises.count)

        selectedBodyPart = bodyPart
        selectedMusclePart = musclePart
        selectedEquipmentPart = equipmentPart

        let response = try await exerciseService.fetchExercises(
            bodyPart: selectedBodyPart,
            muscle: selectedMusclePart,
            equipment: selectedEquipmentPart
        )

        print("🟠 APPLY RESPONSE COUNT:", response.data.count)

        exercises = response.data

        print("🟠 COUNT AFTER REPLACE:", exercises.count)

        nextCursor = response.meta.nextCursor
        hasNextPage = response.meta.hasNextPage
    }
}
