//
//  ViewControllerLifeCycleObservers.swift
//  LifeCycleObserversTests
//
//  Created by Raluca Mesterca on 12/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import XCTest
@testable import LifeCycleObservers

class ViewControllerLifeCycleObservers: XCTestCase {

    func testViewWillAppearObserverIsAddedAsChild() {
        let sut = UIViewController()
        sut.onViewWillAppear { }

        XCTAssertEqual(sut.children.count, 1)
    }

    func testViewWillAppearObserverIsAddedAsSubview() {

        let sut = UIViewController()
        sut.onViewWillAppear { }
        let observer = sut.children.first

        XCTAssertEqual(observer?.view.superview, sut.view)
    }

    func testViewWillAppearObserverViewIsInvisible() {
        let sut = UIViewController()
        sut.onViewWillAppear { }
        let observer = sut.children.first

        XCTAssertEqual(observer?.view.isHidden, true)
    }

    func testViewWillAppearObserverFiresCallback() {
        let sut = UIViewController()
        var count = 0

        sut.onViewWillAppear { count += 1 }
        let observer = sut.children.first

        XCTAssertEqual(count, 0)

        observer?.viewWillAppear(false)
        XCTAssertEqual(count, 1)

        observer?.viewWillAppear(false)
        XCTAssertEqual(count, 2)
    }

    func testCanRemoveViewWillAppearObserver() {
        let sut = UIViewController()
        sut.onViewWillAppear (run: {}).remove()
        XCTAssertEqual(sut.children.count, 0)

    }

    func testCanRemoveViewWillAppearObserverView() {
           let sut = UIViewController()
           sut.onViewWillAppear (run: {}).remove()
        XCTAssertEqual(sut.view.subviews.count, 0)

       }
}
