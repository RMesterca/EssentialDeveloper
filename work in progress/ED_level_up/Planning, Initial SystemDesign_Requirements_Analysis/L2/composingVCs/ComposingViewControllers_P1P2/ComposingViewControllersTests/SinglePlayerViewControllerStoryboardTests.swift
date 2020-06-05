//
//  SinglePlayerViewControllerStoryboardTests.swift
//  ComposingViewControllersTests
//
//  Created by Raluca Mesterca on 12/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import XCTest
@testable import ComposingViewControllers

class SinglePlayerViewControllerStoryboardTests: XCTestCase {

    let storyboard = UIStoryboard(name: "SinglePlayerGame", bundle: nil)


    func test_singlePlayerGameStoryboardInitialViewController_isSinglePlayerViewController() {
        XCTAssert(storyboard.instantiateInitialViewController() is SinglePlayerViewController)
    }

    func test_singlePlayerGameStoryboard_setsUpPlayerForSinglePlayerViewController() {
        let vc = storyboard.instantiateInitialViewController() as! SinglePlayerViewController
        _ = vc.view
        XCTAssertNotNil(vc.player)
    }
}
