//
//  ResultsViewController.swift
//  TriviaApp
//
//  Created by Sumit Nalavade on 11/25/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var totalQuestions = 0
    var correctQuestions = 0
    
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultsLabel.text = "You got \(correctQuestions) out of \(totalQuestions)"
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.layer.cornerRadius = 5
    }
    
    /*
     Dismiss both the QuestionViewController and the ResultsViewController
    */
    @objc func reset() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }

}
