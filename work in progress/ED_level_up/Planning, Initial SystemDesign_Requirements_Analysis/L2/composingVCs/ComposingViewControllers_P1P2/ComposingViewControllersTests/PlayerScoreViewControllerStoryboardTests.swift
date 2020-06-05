//
//  PlayerScoreViewControllerStoryboardTests.swift
//  ComposingViewControllersTests
//
//  Created by Raluca Mesterca on 12/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import XCTest
@testable import ComposingViewControllers

// MARK: Player One Storyboard
class PlayerScoreViewControllerStoryboardTests: XCTestCase {

    func test_playerOneStoryboardInitialViewController_isPlayerScoreViewController() {
        XCTAssert(makePlayerScoreViewController(storyboard: makePlayerOneStoryboard()) is PlayerScoreViewController)
    }

    func test_playerOneStoryboard_nameSetter_updatesNameLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerOneStoryboard())

        _ = vc.view
        vc.name = "some name"

        XCTAssertEqual(vc.nameLabel?.text, "some name")
    }

    func test_playerOneStoryboard_scoreSetter_updatesScoreLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerOneStoryboard())
        vc.score = "some score"

        XCTAssertEqual(vc.scoreLabel?.text, "some score")
    }
}

// MARK: Player Two Storyboard
extension PlayerScoreViewControllerStoryboardTests {

    func test_playerTwoeStoryboardInitialViewController_isPlayerScoreViewController() {
        XCTAssert(makePlayerScoreViewController(storyboard: makePlayerTwoStoryboard()) is PlayerScoreViewController)
    }

    func test_playerTwoStoryboard_nameSetter_updatesNameLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerTwoStoryboard())

        _ = vc.view
        vc.name = "some name"

        XCTAssertEqual(vc.nameLabel?.text, "some name")
    }

    func test_playerTwoStoryboard_scoreSetter_updatesScoreLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerTwoStoryboard())
        vc.score = "some score"

        XCTAssertEqual(vc.scoreLabel?.text, "some score")
    }
}

// MARK: Helper
extension PlayerScoreViewControllerStoryboardTests {

    private func makePlayerOneStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "PlayerOne", bundle: nil)
    }

    private func makePlayerTwoStoryboard() -> UIStoryboard {
           return UIStoryboard(name: "PlayerTwo", bundle: nil)
       }

    private func makePlayerScoreViewController(storyboard: UIStoryboard) -> PlayerScoreViewController {
        let vc = storyboard.instantiateInitialViewController() as! PlayerScoreViewController
        _ = vc.view

        return vc
    }

}
