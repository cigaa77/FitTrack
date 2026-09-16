//
//  ExerciseTableViewCell.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 16.09.26.
//

import UIKit

final class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet private weak var exerciseImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var muscleLabel: UILabel!
    @IBOutlet private weak var equipmentLabel: UILabel!

    override func awakeFromNib() {
        exerciseImageView.layer.cornerRadius = 12
    }

    func configure(with exercise: Exercise) {
        nameLabel.text = exercise.name
        muscleLabel.text = exercise.targetMuscles.joined(separator: ", ")
        equipmentLabel.text = exercise.equipments.joined(separator: ", ")
    }
}
