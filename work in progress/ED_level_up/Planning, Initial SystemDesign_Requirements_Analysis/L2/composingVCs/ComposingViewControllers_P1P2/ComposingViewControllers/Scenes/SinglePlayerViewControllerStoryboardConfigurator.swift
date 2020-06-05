//
//  SinglePlayerViewControllerStoryboardConfigurator.swift
//  ComposingViewControllers
//
//  Created by Raluca Mesterca on 12/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

final class SinglePlayerViewControllerStoryboardConfigurator: NSObject {
    var observation: NSKeyValueObservation?

    @IBOutlet private weak var player: UIViewController? {
        didSet {
            observation = player?.observe(\.parent) { player, changes in
                if let singlePlayerController = player.parent as? SinglePlayerViewController {
                    singlePlayerController.player = player as? PlayerScoreViewController
                }
            }
        }
    }
}
