//
//  MultiPlayerScoreViewController.swift
//  ComposingViewControllers
//
//  Created by Raluca Mesterca on 12/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

class MultiPlayerScoreViewController: UIViewController {
    private(set) var playerOne: PlayerScoreViewController?
    private(set) var playerTwo: PlayerScoreViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayerOne", let vc = segue.destination as? PlayerScoreViewController {
            playerOne = vc
        }
        else if segue.identifier == "PlayerTwo", let vc = segue.destination as? PlayerScoreViewController {
            playerTwo = vc
        }
    }
}
