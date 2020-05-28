//
//  MultiPlayerViewController.swift
//  ComposingViewControllers
//
//  Created by Raluca Mesterca on 11/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

final class MultiPlayerViewController: UIViewController {
//    @IBOutlet private weak var playerOne: PlayerView?
//    @IBOutlet private weak var playerTwo: PlayerView?

//    private weak var player: PlayerScoreViewController?
//    private weak var playerTwo: PlayerScoreViewController?

    private(set) var players: MultiPlayerScoreViewController?

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "Players", let vc = segue.destination as? MultiPlayerScoreViewController {
             players = vc
         }
     }
}
