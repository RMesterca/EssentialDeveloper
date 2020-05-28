//
//  TimeBarViewController.swift
//  ComposingViewControllers
//
//  Created by Raluca Mesterca on 11/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

class TimeBarViewController: UIViewController {

    @IBOutlet private weak var barView: UIView!

    var progress: Float = 1 {
        didSet { // update bar frame
        }
    }
}
