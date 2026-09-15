//
//  RecentActivityCell.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

import UIKit

class RecentActivityTableViewCell: UITableViewCell {

    @IBOutlet private weak var workoutImageView: UIImageView!
    @IBOutlet private weak var workoutNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        workoutImageView.layer.cornerRadius = 8
        workoutImageView.clipsToBounds = true

    }

    func configure(
        name: String,
        date: String,
        duration: String,
        image: UIImage?
    ) {
        workoutNameLabel.text = name
        dateLabel.text = date
        durationLabel.text = duration
        workoutImageView.image = image
    }

}
