//
//  HomeViewController.swift
//  FitTrack
//
//  Created by Ahmet CILINGIR on 15.09.26.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
