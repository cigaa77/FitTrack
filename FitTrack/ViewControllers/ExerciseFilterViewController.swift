//
//  ExerciseFilterViewController.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 16.09.26.
//

import UIKit

protocol ExerciseFilterViewControllerDelegate: AnyObject {
    func exerciseFilterViewController(
        _ viewController: ExerciseFilterViewController,
        didApplyBodyPart bodyPart: String?,
        muscles: String?,
        equipment: String?
    )
}

final class ExerciseFilterViewController: UIViewController {

    @IBOutlet private weak var bodyPartCollectionView: UICollectionView!
    @IBOutlet private weak var muscleCollectionView: UICollectionView!
    @IBOutlet private weak var equipmentCollectionView: UICollectionView!

    private let viewModel = ExerciseFilterViewModel()

    weak var delegate: ExerciseFilterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        bodyPartCollectionView.delegate = self
        bodyPartCollectionView.dataSource = self

        muscleCollectionView.delegate = self
        muscleCollectionView.dataSource = self

        equipmentCollectionView.delegate = self
        equipmentCollectionView.dataSource = self
    }

    @IBAction func resetButtonTapped(_ sender: Any) {
        viewModel.resetFilters()

        bodyPartCollectionView.reloadData()
        muscleCollectionView.reloadData()
        equipmentCollectionView.reloadData()
    }

    @IBAction func applyFiltersButtonTapped(_ sender: Any) {

        delegate?.exerciseFilterViewController(
            self,
            didApplyBodyPart: viewModel.appliedBody,
            muscles: viewModel.appliedMuscle,
            equipment: viewModel.appliedEquipment
        )
        
        dismiss(animated: true)
    }

}

extension ExerciseFilterViewController: UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        switch collectionView {
        case bodyPartCollectionView:
            return viewModel.bodyParts.count
        case muscleCollectionView:
            return viewModel.muscles.count
        case equipmentCollectionView:
            return viewModel.equipments.count
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FilterOptionCell",
                for: indexPath
            ) as? FilterOptionCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        switch collectionView {
        case bodyPartCollectionView:
            let bodyPart = viewModel.bodyParts[indexPath.item]

            cell.configure(
                title: viewModel.bodyParts[indexPath.item],
                isSelected: bodyPart == viewModel.selectedBodyPart
            )
        case muscleCollectionView:
            let muscle = viewModel.muscles[indexPath.item]

            cell.configure(
                title: viewModel.muscles[indexPath.item],
                isSelected: muscle == viewModel.selectedMuscle
            )
        case equipmentCollectionView:
            let equipment = viewModel.equipments[indexPath.item]

            cell.configure(
                title: viewModel.equipments[indexPath.item],
                isSelected: equipment == viewModel.selectedEquipment
            )
        default:
            return UICollectionViewCell()
        }

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let title: String
        switch collectionView {
        case bodyPartCollectionView:
            title = viewModel.bodyParts[indexPath.item]
        case muscleCollectionView:
            title = viewModel.muscles[indexPath.item]
        case equipmentCollectionView:
            title = viewModel.equipments[indexPath.item]

        default:
            return CGSize()
        }
        let width =
            (title as NSString).size(withAttributes: [
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)
            ]).width + 32

        return CGSize(width: width, height: 40)

    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch collectionView {
        case bodyPartCollectionView:
            viewModel.selectBodyPart(at: indexPath.item)
        case muscleCollectionView:
            viewModel.selectMuscle(at: indexPath.item)
        case equipmentCollectionView:
            viewModel.selectEquipment(at: indexPath.item)
        default:
            return
        }
        collectionView.reloadData()
    }
}
