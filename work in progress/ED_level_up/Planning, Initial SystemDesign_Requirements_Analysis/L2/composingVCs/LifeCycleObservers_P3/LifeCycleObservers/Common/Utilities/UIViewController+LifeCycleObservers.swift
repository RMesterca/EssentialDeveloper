//
//  UIViewController+LifeCycleObservers.swift
//  LifeCycleObservers
//
//  Created by Raluca Mesterca on 12/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

protocol UIViewControllerLifecycleObserver {
    func remove()
}

extension UIViewController {

    @discardableResult
    func onViewWillAppear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(viewWillAppearCallback: callback)
        add(observer)
        return observer
    }

    private func add(_ observer: UIViewController) {
        addChild(observer)
        observer.view.isHidden = true
        view.addSubview(observer.view)
        observer.didMove(toParent: self)
    }
}


private class ViewControllerLifeCycleObserver: UIViewController, UIViewControllerLifecycleObserver {

    private var viewWillAppearCallBack: () -> Void = { }

    convenience init(viewWillAppearCallback: @escaping () -> Void = {} ) {
        self.init()
        self.viewWillAppearCallBack = viewWillAppearCallback
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)

        viewWillAppearCallBack()
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
