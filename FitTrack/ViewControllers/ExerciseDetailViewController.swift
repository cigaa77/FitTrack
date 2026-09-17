//
//  ExerciseDetailViewController.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 17.09.26.
//

import UIKit

final class ExerciseDetailViewController: UIViewController {

    @IBOutlet private weak var exerciseImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var instructionsLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var primaryMuscleLabel: UILabel!
    @IBOutlet private weak var secondaryMusclesLabel: UILabel!
    @IBOutlet private weak var equipmentLabel: UILabel!

    var exercise: Exercise?

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never

        exerciseImageView.backgroundColor = .systemRed
        if let name = exercise?.name {
            nameLabel.text = name
        }
        if let bodyPart = exercise?.bodyParts,
            let muscle = exercise?.targetMuscles,
            let equipment = exercise?.equipments
        {
            summaryLabel.text =
                bodyPart.joined(separator: ", ") + " - "
                + muscle.joined(separator: ", ") + " - "
                + equipment.joined(separator: ", ")
        }

        if let muscle = exercise?.targetMuscles {
            primaryMuscleLabel.text = muscle.joined(separator: ", ")
        }

        if let secondaryMuscle = exercise?.secondaryMuscles {
            secondaryMusclesLabel.text = secondaryMuscle.joined(separator: ", ")
        }

        if let equipment = exercise?.equipments {
            equipmentLabel.text = equipment.joined(separator: ", ")
        }
        
        if let instructions = exercise?.instructions {
            instructionsLabel.text = instructions.joined(separator: "\n")
        }

    }
}
