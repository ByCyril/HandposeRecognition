//
//  GestureRecognizerTests.swift
//  GestureRecognizerTests
//
//  Created by Cyril Garcia on 7/10/20.
//

import XCTest

@testable import GestureRecognizer
class GestureRecognizerTests: XCTestCase {

    func testSlopeMethod() {
        let lsm = LeastSquareMethod()
        XCTAssertEqual(lsm.slope([1.8,1.9,2.0,2.1], [4.0,3.3,2.0,1.0]), -10.3, accuracy: 0.01)
        XCTAssertEqual(lsm.slope([1.3,1.5,1.5,1.9], [1,2,3.2,4.3]), 5.237, accuracy: 0.01)
        
        XCTAssertEqual(lsm.slope([CGPoint(x: 1.8, y: 4.0),
                                  CGPoint(x: 1.9, y: 3.3),
                                  CGPoint(x: 2.0, y: 2.0),
                                  CGPoint(x: 2.1, y: 1.0)]), -10.3, accuracy: 0.01)
        
        XCTAssertEqual(lsm.slope([CGPoint(x: 1.3, y: 1.0),
                                  CGPoint(x: 1.5, y: 2.0),
                                  CGPoint(x: 1.5, y: 3.2),
                                  CGPoint(x: 1.9, y: 4.3)]), 5.237, accuracy: 0.01)
    }

}
