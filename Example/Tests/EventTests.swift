//
//  EventTests.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 09/05/15.
//  Copyright (c) 2015 Accedo Products - Mobile. All rights reserved.
//

import XCTest
import Turnstile

class EventTests: XCTestCase {
    
    private struct Constants {
        static let eventName = "Event under test"
        static let sourceStates = [State(value: "State 1"), State(value: "State 2")]
        static let destinationState = State(value: "State3")
        static let stringDiff = "💩"
    }
    
    var event: Event<String>?

    override func setUp() {
        super.setUp()
        event = Event(name: Constants.eventName, sourceStates: Constants.sourceStates, destinationState: Constants.destinationState)
    }
    
    override func tearDown() {
        event = nil
        super.tearDown()
    }
    
    func testEventCanBeConstructed() {
        XCTAssertNotNil(event, "Event must not be nil")
    }
    
    func testEventNameIsSetProperly() {
        XCTAssertNotNil(event?.name, "Event name must not be nil")
    }
    
    func testEqualEventsAreEqual() {
        let secondEvent = Event(name: Constants.eventName, sourceStates: Constants.sourceStates, destinationState: Constants.destinationState)
        
        XCTAssertTrue( event == secondEvent, "A event must be equal to itself")
    }
    
    func testEventsWithDifferentNamesAreDifferent() {
        let secondEvent = Event(name: Constants.eventName + Constants.stringDiff, sourceStates: Constants.sourceStates, destinationState: Constants.destinationState)
        
        XCTAssertFalse( event == secondEvent, "Events with different name are different")
    }
    
    func testEventsWithDiffrentSourceStatesAndSameNameAreDifferent() {
        let secondEvent = Event(name: Constants.eventName, sourceStates: [State(value: "State 3")], destinationState: Constants.destinationState)
        XCTAssertFalse( event == secondEvent, "Events with different source states are different") 
    }
    
    func testEventsWithSameNameAndSourceEventsAndDifferentDestinationEventsAreDifferent() {
        let secondEvent = Event(name: Constants.eventName, sourceStates: Constants.sourceStates , destinationState: State(value: "State 3"))
        XCTAssertFalse( event == secondEvent, "Events with different destination states are different")
        
    }
    
    func testSourceStatesCanBeSet() {
        XCTAssertTrue((event!.sourceStates == Constants.sourceStates), "Source states must be set properly")
    }    
}
