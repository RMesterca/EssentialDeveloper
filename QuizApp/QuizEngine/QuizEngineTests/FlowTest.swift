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
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestions.isEmpty)
    }

    func test_start_withOneQuestion_routeToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestionCount, 1)
    }

    func test_start_withOneQuestion_routeToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestion, "Q1")
    }

    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestion, "Q2")
    }

    func test_start_withTwoQuestion_routeToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestion, "Q1")
    }



//    func test_startTwice_withTwoQuestion_routeToFirstQuestionTwice() {
//        let router = RouterSpy()
//        let sut = Flow(questions: ["Q1", "Q2"], router: router)
//        sut.start()
//        sut.start()
//
//        XCTAssertEqual(router.routedQuestion, "Q1")
//    }
}

// MARK: Spy
private extension FlowTest {

    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil
        var routedQuestions: [String] = []


        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
            routedQuestion?.append(question)
        }
    }
}


