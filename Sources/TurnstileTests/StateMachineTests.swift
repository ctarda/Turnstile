//
//  StateMachineTests.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 10/05/15.
//

import XCTest
import Turnstile

class StateMachineTests: XCTestCase {
    
    private struct Constants {
        static let state1 = State(value: "State 1")
        static let state2 = State(value: "State 2")
        static let state3 = State(value: "State 3")
        static let stringDiff = "💩"
        
        static let event1 = Event(name: stringDiff, sourceStates: [state1], destinationState: state2)
    }
    
    var stateMachine: StateMachine<String>?

    override func setUp() {
        super.setUp()
        stateMachine = StateMachine(initialState: Constants.state1, states: [Constants.state2, Constants.state3])
    }
    
    override func tearDown() {
        stateMachine = nil
        super.tearDown()
    }

    func testInitWithInitialStateAndOtherStatesCreatesInstance() {
        XCTAssertEqual(stateMachine!.initialState, Constants.state1, "Initial state must be set properly")
    }

    func testInitiWithInitialStateOnlyAlsoCreatesInstance() {
        let newStateMachine = StateMachine(initialState: Constants.state1)
        XCTAssertEqual(newStateMachine.initialState, Constants.state1, "Initial state must be set properly")
    }
    
    func testIsExistingState() {
        XCTAssertTrue(stateMachine!.isExistingState(Constants.state1), "Initial state must be part of the machine")
    }
    
    func testIsExistingStateReturnsFalseIfStateIsNotInMachine() {
        let fourthState = State(value: Constants.stringDiff)
        
        XCTAssertFalse(stateMachine!.isExistingState(fourthState), "Non-exiting states should be caught")
    }
    
    func testAddStateAddsState() {
        let fourthState = State(value: Constants.stringDiff)
        stateMachine?.addState(fourthState)
        
        XCTAssertTrue(stateMachine!.isExistingState(fourthState), "Added states must be part of the machine")
    }
    
    func testAddStatesAddsStates() {
        let fourthState = State(value: Constants.stringDiff)
        let fifthState = State(value: Constants.stringDiff + Constants.stringDiff)
        stateMachine?.addStates([fourthState, fifthState])
        
        let fourthWasAdded = stateMachine!.isExistingState(fourthState)
        let fifthWasAdded = stateMachine!.isExistingState(fifthState)
        
        XCTAssertTrue(fourthWasAdded && fifthWasAdded, "Added states must be part of the machine")
    }
    
    func testAddEventAddsEventIfAllStatesArePresent() {
        stateMachine?.addEvent(Constants.event1)
        XCTAssertTrue(stateMachine!.isExistingEvent(Constants.event1), "The state machine should accept an event linking two existing states")
    }
    
    func testAddEventsAddEvents() {
        let event2 = Event(name: "Event2", sourceStates: [Constants.state1], destinationState: Constants.state3)
        let event3 = Event(name: "Event3", sourceStates: [Constants.state2], destinationState: Constants.state3)
        
        stateMachine?.addEvents([event2, event3])
        
        let secondEventWasAdded = stateMachine!.isExistingEvent(event2)
        let thirdEventWasAdded = stateMachine!.isExistingEvent(event3)
        
        XCTAssertTrue(secondEventWasAdded && thirdEventWasAdded, "Added events must be part of the machine")
    }
    
    func testIsInStateReturnsTrueWhenCheckingTheInitialStateIfTheMachineHasNotBeenStarted() {
        XCTAssertTrue(stateMachine!.isInState(Constants.state1), "The state machine should be in the initial state when it has not been started")
    }
    
    func testIsInStateReturnsFalseWhenCheckingTheSecondStateIfTheMachineHasNotBeenStarted() {
        XCTAssertFalse(stateMachine!.isInState(Constants.state2), "The state machine should be in the initial state when it has not been started")
    }
    
    func testStateMachineCanNotStartIfItOnlyHasOneStateAndNoEvents() {
        let oneStateMachine = StateMachine(initialState: Constants.state1)
        
        let isStarted = oneStateMachine.start()
        
        XCTAssertTrue(!isStarted && !oneStateMachine.isRunning(), "The state machine can not start with only one state and no transitions")
    }
    
    func testStateMachineCanNotStartIfThereAreNoEvents() {
        let twoStatesMachine = StateMachine(initialState: Constants.state1)
        twoStatesMachine.addState(Constants.state2)
        
        let isStarted = twoStatesMachine.start()
        
        XCTAssertTrue(!isStarted && !twoStatesMachine.isRunning(), "The state machine can not start with two states and no transitions")
    }
    
    func testStateMachineCanNotStartIfThereAreNoEventsLinkingStates() {
        let twoStatesMachine = StateMachine(initialState: Constants.state1)
        twoStatesMachine.addState(Constants.state2)
        
        let isStarted = twoStatesMachine.start()
        
        XCTAssertTrue(!isStarted && !twoStatesMachine.isRunning(), "The state machine can not start with two states and no transitions")
    }
    
    func testStateMachineWillStartWithOneStateAndOneValidEvent(){
        let selfEvent = Event(name: Constants.stringDiff, sourceStates: [Constants.state1], destinationState: Constants.state1)
        let oneStateMachine = StateMachine(initialState: Constants.state1)
        oneStateMachine.addEvent(selfEvent)
        
        let isStarted = oneStateMachine.start()
        
        XCTAssertTrue(isStarted && oneStateMachine.isRunning(), "The state machine will start with only one state and one valid transition")
    }
    
    func testStateMachineWillStartWithTwoStatesAndAProperEvent(){
        let event = Event(name: Constants.stringDiff, sourceStates: [Constants.state3], destinationState: Constants.state1)
        stateMachine?.addEvent(event)
        
        let isStarted = stateMachine!.start()
        
        XCTAssertTrue(isStarted && stateMachine!.isRunning(), "The state machine will start proper states and transitions")
    }
    
    func testFireEventFailsTransitionWhenStateMachineIsNotInDestionationState() {
        let event = Event(name: Constants.stringDiff, sourceStates: [Constants.state3], destinationState: Constants.state1)
        stateMachine?.addEvent(event)
        stateMachine!.start()
        
        let transitionResult = stateMachine!.fireEvent(event)
        
        XCTAssertTrue(transitionResult == .Inconsistent, "An event shall not be fired if the state machine is not in the proper state")
    }
    
    func testFireEventFailsIfMachineIsNotStarted() {
        stateMachine?.addEvent(Constants.event1)

        let transitionResult = stateMachine!.fireEvent(Constants.event1)
        
        XCTAssertTrue(transitionResult == .Inconsistent, "An event shall not be fired if the state machine is not started")
    }
    
    func testMachineShouldBeInState2AfterEventFromState1ToState2() {
        stateMachine?.addEvent(Constants.event1)
        stateMachine!.start()
        
        let transitionResult = stateMachine!.fireEvent(Constants.event1)
        
        XCTAssertTrue(transitionResult == .Completed && stateMachine!.isInState(Constants.state2), "An event from state1 to state 2 should leave machine in state 2")
    }
    
    func testWillEnterStateGetsFired() {
        var stateEntered = false
        let state2 = Constants.state2
        state2.willEnterState = {state in stateEntered = true}
        
        let event = Event(name: Constants.stringDiff, sourceStates: [Constants.state1], destinationState: state2)
        let oneStateMachine = StateMachine(initialState: Constants.state1)
        oneStateMachine.addState(state2)
        oneStateMachine.addEvent(event)
        
        oneStateMachine.start()
        
        oneStateMachine.fireEvent(event)
        
        XCTAssertTrue(stateEntered, "The state machine will run the proper closure before entering a state")
    }
    
    func testDidEnterStateGetsFired() {
        var stateEntered = false
        let state2 = Constants.state2
        state2.didEnterState = {state in stateEntered = true}
        
        let event = Event(name: Constants.stringDiff, sourceStates: [Constants.state1], destinationState: state2)
        let oneStateMachine = StateMachine(initialState: Constants.state1)
        oneStateMachine.addState(state2)
        oneStateMachine.addEvent(event)
        
        oneStateMachine.start()
        
        oneStateMachine.fireEvent(event)
        
        XCTAssertTrue(stateEntered, "The state machine will run the proper closure when entering a state")
    }
    
    func testWillExitStateGetsFired() {
        var stateEntered = false
        let state1 = Constants.state1
        let state2 = Constants.state2
        state1.willExitState = {state in stateEntered = true}
        
        let event = Event(name: Constants.stringDiff, sourceStates: [state1], destinationState: state2)
        let oneStateMachine = StateMachine(initialState: state1)
        oneStateMachine.addState(state2)
        oneStateMachine.addEvent(event)
        
        oneStateMachine.start()
        
        oneStateMachine.fireEvent(event)
        
        XCTAssertTrue(stateEntered, "The state machine will run the proper closure before exiting a state")
    }
    
    func testDidExitStateGetsFired() {
        var stateEntered = false
        let state1 = Constants.state1
        let state2 = Constants.state2
        state1.didExitState = {state in stateEntered = true}
        
        let event = Event(name: Constants.stringDiff, sourceStates: [state1], destinationState: state2)
        let oneStateMachine = StateMachine(initialState: state1)
        oneStateMachine.addState(state2)
        oneStateMachine.addEvent(event)
        
        oneStateMachine.start()
        
        oneStateMachine.fireEvent(event)
        
        XCTAssertTrue(stateEntered, "The state machine will run the proper closure after exiting a state")
    }
    
    func partialStateMachine() -> StateMachine<String> {
        let state1 = Constants.state1
        let state2 = Constants.state2
        let state3 = Constants.state3
        let event12 = Event(name: Constants.stringDiff, sourceStates: [state1], destinationState: state2)
        let sut = StateMachine(initialState: state1)
        sut.addState(state2)
        sut.addState(state3)
        sut.addEvent(event12)

        return sut
    }
    
    func testMachineTansitionIsNotAllowedIfItsNotRunning() {
        let sut = partialStateMachine()
        XCTAssertFalse(sut.canTransitionTo(Constants.state2), "Transitions are allowed only on running state machines")
    }

    func testMachineTansitionIsNotAllowedToInexistantStates() {
        let sut = partialStateMachine()
        let state4 = State(value: Constants.stringDiff)
        sut.start()
        XCTAssertFalse(sut.canTransitionTo(state4), "If the destination state is not configured into the state machine, the transition is not allowed")
    }
        
    func testMachineCanSayIfATransitionIsCurrentlyAllowed() {
        let sut = partialStateMachine()
        sut.start()
        XCTAssertTrue(sut.canTransitionTo(Constants.state2), "A transition is allowed if we are in the source state of some event that transition to destination state")
    }
    
    func testMachineCanSayIfATransitionIsCurrentlyNotAllowed() {
        let sut = partialStateMachine()
        sut.start()
        XCTAssertFalse(sut.canTransitionTo(Constants.state3), "A transition is not allowed if we are in the source state none event that transition to destination state")
    }
    
}
