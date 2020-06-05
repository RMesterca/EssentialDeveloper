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

    func test_start_withNoQuestion_doesNotRouteToQuestion() {

        // Given
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)

        // When
        sut.start()

        //Then
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }


    func test_start_withOneQuestion_routeToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }

    func test_start_withTwoQuestion_routeToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startTwice_withTwoQuestion_routeToFirstQuestionTwice() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstQuestion_withTwoQuestion_routeToSecondQuestion() {
        // Given
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        sut.start()

        // When
        router.answerCallback("Q1")

        // Then
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
}

// MARK: Spy
private extension FlowTest {

    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: (String) -> Void = { _ in }

        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}


