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
            // weak vs unknown
            // weak creates an optional, unknown doesn't (but it can crash the app)
            // since I have a reference to the router and I'm passing this message there
            // it means the router is never going to be nil
            // the problem is if this router passes this block to some other instance
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let strongSelf = self else { return }
                let firstQuestionIndex = strongSelf.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex + 1]
                strongSelf.router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
