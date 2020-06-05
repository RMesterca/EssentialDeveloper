//
//  PlayerScoreViewController.swift
//  ComposingViewControllers
//
//  Created by Raluca Mesterca on 11/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

class PlayerScoreViewController: UIViewController {
    @IBOutlet private(set) weak var nameLabel: UILabel?
    @IBOutlet private(set) weak var scoreLabel: UILabel?

    var name: String? {
        set { nameLabel?.text = newValue }
        get { return nameLabel?.text }
    }

    var score: String? {
        set { scoreLabel?.text = newValue }
        get { return scoreLabel?.text }
    }
}
