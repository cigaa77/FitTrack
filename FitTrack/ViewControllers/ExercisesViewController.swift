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
    @IBOutlet private weak var emptyStateView: UIView!

    private let viewModel = ExercisesViewModel()
    private let searchController = UISearchController(
        searchResultsController: nil
    )

    private var searchTask: Task<Void, Never>?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        tableView.dataSource = self
        tableView.delegate = self

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Exercises"

        emptyStateView.isHidden = true

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

                updateStateEmpty()
            } catch {
                print(error)
                activityIndicator.stopAnimating()
                errorStackView.isHidden = false
                tableView.isHidden = true
            }
        }
    }

    private func fetchNextPage() {
        Task {
            do {
                try await viewModel.fetchExercises()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    private func updateStateEmpty() {
        let isEmpty = viewModel.numberOfExercises == 0

        emptyStateView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let filterViewController = segue.destination
            as? ExerciseFilterViewController
        {
            filterViewController.delegate = self
        }

        if segue.identifier == "showExerciseDetail",
            let detailViewController = segue.destination
                as? ExerciseDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            let exercise = viewModel.exercise(at: indexPath.row)
        {
            detailViewController.exercise = exercise
        }
    }

    @IBAction func retryButtonTapped(_ sender: UIButton) {
        fetchExercises()
    }

}

extension ExercisesViewController: UITableViewDataSource, UITableViewDelegate {

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
                withIdentifier: "ExerciseCell",
                for: indexPath
            ) as? ExerciseTableViewCell
        else {
            return UITableViewCell()
        }
        print(
            "CELL REQUEST:",
            indexPath.row,
            "ARRAY COUNT:",
            viewModel.numberOfExercises
        )

        guard let exercise = viewModel.exercise(at: indexPath.row) else {
            return UITableViewCell()
        }

        cell.configure(with: exercise)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        print(
            "WILL DISPLAY:",
            indexPath.row,
            "ARRAY COUNT:",
            viewModel.numberOfExercises
        )
        guard viewModel.hasNextPage else {
            return
        }

        if indexPath.row >= viewModel.numberOfExercises - 5 {
            print(">>> PAGINATION TRIGGERED <<<")
            fetchNextPage()
        }
    }
}

extension ExercisesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        searchTask?.cancel()

        guard let searchText = searchController.searchBar.text,
            !searchText.isEmpty
        else {
            return
        }

        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(500))

            guard !Task.isCancelled else { return }

            do {
                try await viewModel.searchExercises(name: searchText)
                tableView.reloadData()
                updateStateEmpty()
            } catch {
                print(error)
            }
        }
    }
}

extension ExercisesViewController: ExerciseFilterViewControllerDelegate {
    func exerciseFilterViewController(
        _ viewController: ExerciseFilterViewController,
        didApplyBodyPart bodyPart: String?,
        muscles: String?,
        equipment: String?
    ) {
        tableView.setContentOffset(
            tableView.contentOffset,
            animated: false
        )

        Task {
            do {
                try await viewModel.applyFilters(
                    bodyPart: bodyPart,
                    musclePart: muscles,
                    equipmentPart: equipment
                )

                tableView.reloadData()
                updateStateEmpty()
                tableView.setContentOffset(.zero, animated: false)

            } catch {
                print(error)
            }
        }
    }

}
