//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Raluca Mesterca on 05/06/2020.
//  Copyright © 2020 fig. All rights reserved.
//
@testable import QuizEngine
import XCTest
import Foundation


class FlowTest: XCTestCase {

    let router = RouterSpy()

    func test_start_withNoQuestion_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }

    func test_start_withOneQuestion_routeToCorrectQuestion() {
         makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }

    func test_start_withTwoQuestion_routeToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startTwice_withTwoQuestion_routeToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstQuestion_withTwoQuestion_routeToSecondQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }

    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routeToSecondAndThirdQuestion() {
        makeSUT(questions: ["Q1", "Q2", "Q3"]).start()
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
}

// MARK: Spy
extension FlowTest {

    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: (String) -> Void = { _ in }

        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }

    func makeSUT(questions: [String]) -> Flow {
           return Flow(questions: questions, router: router)
       }
}


