//
//  TimedMultiPlayerViewController.swift
//  ComposingViewControllers
//
//  Created by Raluca Mesterca on 12/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

class TimedMultiPlayerViewController: UIViewController {
    private(set) var timeBar: TimeBarViewController?
    private(set) var players: MultiPlayerScoreViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TimeBar", let vc = segue.destination as? TimeBarViewController {
            timeBar = vc
        }
        else if segue.identifier == "Players", let vc = segue.destination as? MultiPlayerScoreViewController {
            players = vc
        }
    }
}
