//
//  StateTests.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 09/05/15.
//  Copyright (c) 2015 Accedo Products - Mobile. All rights reserved.
//


import XCTest
import Turnstile

class StateTests: XCTestCase {
    
    private struct Constants {
        static let stateValue = "State under testing"
        static let stringDiff = "💩"
    }

    var state: State<String>?
    
    override func setUp() {
        super.setUp()
        state = State(value: Constants.stateValue)
    }
    
    override func tearDown() {
        state = nil
        super.tearDown()
    }

    func testStateIsCreated() {
        XCTAssertNotNil(state, "State must not be nil")
    }
    
    func testStateValueIsSet() {
        XCTAssertEqual(state!.value, Constants.stateValue, "value must be set properly")
    }
    
    func testStateWillEnterStateCanBeSet() {
        var result = false
        
        state!.willEnterState = { state in result = true }
        state!.willEnterState?(finalState: state!)
        
        XCTAssertTrue(result, "willEnterState must be set")
    }
    
    func testStateDidEnterStateCanBeSet() {
        var result = false
        
        state!.didEnterState = { state in result = true }
        state!.didEnterState?(finalState: state!)
        
        XCTAssertTrue(result, "didEnterState must be set")
    }
    
    func testStateWillExitStateCanBeSet() {
        var result = false
        
        state!.willExitState = { state in result = true }
        state!.willExitState?(initialState: state!)
        
        XCTAssertTrue(result, "willExitState must be set")
    }
    
    func testStateDidExitStateCanBeSet() {
        var result = false
        
        state!.didExitState = { state in result = true }
        state!.didExitState?(initialState: state!)
        
        XCTAssertTrue(result, "willExitState must be set")
    }
    
    func testStatesWithSameValueAreEqual() {
        let secondState = State(value: Constants.stateValue)
        
        XCTAssertTrue(state == secondState, "State with same value are equal")
    }
    
    func testStatesWithDifferentValueAreDifferent() {
        let secondState = State(value: Constants.stateValue + Constants.stringDiff)
        
        XCTAssertFalse(state == secondState, "State with differnet value are different")
    }

}
