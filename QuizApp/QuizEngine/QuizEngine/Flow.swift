//
//  Flow.swift
//  QuizEngine
//
//  Created by Raluca Mesterca on 05/06/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class Flow {
    let router: Router
    let questions: [String]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion)
        }
    }
}
