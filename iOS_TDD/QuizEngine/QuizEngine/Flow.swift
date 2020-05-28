//
//  Flow.swift
//  QuizEngine
//
//  Created by Raluca Mesterca on 18/01/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class Flow {

    let router: Router
    let questions: [String]

    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }

    func start() {
        guard !questions.isEmpty else { return }
        router.routeTo(question: "")
    }
}
