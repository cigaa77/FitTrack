//
//  ExerciseFilterViewModel.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 16.09.26.
//

import Foundation

final class ExerciseFilterViewModel {

    let bodyParts = [
        "All",
        "Chest",
        "Back",
        "Shoulders",
        "Upper Arms",
        "Upper Legs",
    ]

    private(set) var selectedBodyPart = "All"

    func selectBodyPart(at index: Int) {
        selectedBodyPart = bodyParts[index]
    }

    let muscles = [
        "All",
        "Biceps",
        "Triceps",
        "Pectorals",
        "Delts",
        "Lats",
        "Abs",
    ]

    private(set) var selectedMuscle = "All"

    func selectMuscle(at index: Int) {
        selectedMuscle = muscles[index]
    }

    let equipments = [
        "All",
        "Dumbbell",
        "Barbell",
        "Cable",
        "Body Weight",
        "Kettlebell",
    ]

    private(set) var selectedEquipment = "All"

    func selectEquipment(at index: Int) {
        selectedEquipment = equipments[index]
    }
    
    var appliedBody: String? {
        selectedBodyPart == "All" ? nil : selectedBodyPart
    }
    
    var appliedMuscle: String? {
        selectedMuscle == "All" ? nil : selectedMuscle
    }
    
    var appliedEquipment: String? {
        selectedEquipment == "All" ? nil : selectedEquipment
    }
    
    func resetFilters(){
        selectedBodyPart = "All"
        selectedMuscle = "All"
        selectedEquipment = "All"
    }
    
}
