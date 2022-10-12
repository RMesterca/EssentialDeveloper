//
//  Flow.swift
//  QuizEngine
//
//  Created by Raluca Mesterca on 05/06/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
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
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))

        }
    }

    func routeNext(_ question: String) -> (String) -> Void {
        return { [weak self] _ in
            guard let self = self else { return }
            let currentQuestionIndex = self.questions.firstIndex(of: question)!
            let nextQuestion = self.questions[currentQuestionIndex + 1]
            self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(nextQuestion))
        }
    }
}
