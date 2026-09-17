//
//  FilterOptionCollectionViewCell.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 16.09.26.
//

import UIKit

final class FilterOptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(title: String, isSelected: Bool){
        
        titleLabel.text = title
        
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        if isSelected {
            contentView.backgroundColor = .label
            titleLabel.textColor = .systemBackground
        } else {
            contentView.backgroundColor = .secondarySystemBackground
            titleLabel.textColor = .label
        }
        
    }
    
}
