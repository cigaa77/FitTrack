//
//  HomeViewController.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var todayWorkoutCardView: UIView!
    @IBOutlet private weak var recentActivityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        todayWorkoutCardView.layer.cornerRadius = 16
        todayWorkoutCardView.backgroundColor = .secondarySystemBackground

        recentActivityTableView.dataSource = self
    }
    private let recentWorkouts = [
        (
            name: "Push Day",
            date: "Sep 14, 2024",
            duration: "48 min"
        ),
        (
            name: "Leg Day",
            date: "Sep 12, 2024",
            duration: "55 min"
        ),
    ]
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return recentWorkouts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "RecentActivityCell"
            ) as? RecentActivityTableViewCell
        else { return UITableViewCell() }
        let workout = recentWorkouts[indexPath.row]

        cell.configure(
            name: workout.name,
            date: workout.date,
            duration: workout.duration,
            image: nil
        )
        return cell
    }
}
