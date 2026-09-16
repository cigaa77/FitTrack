//
//  ExercisesViewController.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

import UIKit

final class ExercisesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var errorStackView: UIStackView!

    private let viewModel = ExercisesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        tableView.dataSource = self

        fetchExercises()
    }

    private func fetchExercises() {

        errorStackView.isHidden = true
        tableView.isHidden = true
        activityIndicator.startAnimating()

        Task {
            do {
                try await viewModel.fetchExercises()
                tableView.reloadData()

                errorStackView.isHidden = true
                activityIndicator.stopAnimating()
                tableView.isHidden = false
            } catch {
                print(error)
                activityIndicator.stopAnimating()
                errorStackView.isHidden = false
                tableView.isHidden = true
            }
        }
    }

    @IBAction func retryButtonTapped(_ sender: UIButton) {
        fetchExercises()
    }
}

extension ExercisesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.numberOfExercises
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ExerciseCell"
            ) as? ExerciseTableViewCell
        else {
            return UITableViewCell()
        }

        let exercise = viewModel.exercise(at: indexPath.row)

        cell.configure(with: exercise)

        return cell
    }
}
