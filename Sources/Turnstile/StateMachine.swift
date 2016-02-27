//
//  StateMachine.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 10/05/15.
//

import Foundation

/**
 A StateMachine aggregates states. It will transition from one state to another when events are triggered, according to the destination state of those events
*/
public class StateMachine <T: Hashable> {
    
    private(set) public final var initialState: State<T>
    private final lazy var states : [State<T>] = []
    private final lazy var events : [Event<T>] = []
    private var currentState: State<T>
    private var running = false
    
    required public init(initialState: State<T>) {
        self.initialState = initialState
        currentState = initialState        
        states.append(initialState)
    }
    
    convenience public init(initialState: State<T>, states: [State<T>])
    {
        self.init(initialState: initialState)
        self.states.appendContentsOf(states)
    }
    /**
     Checks if the state machine contains a given state
    */
    public func isExistingState(state: State<T>) -> Bool {
        return states.contains(state)
    }
    
    /**
     Adds a state to the state machine. Fails silently if the state had been previously added to the machine.
    */
    public func addState(state: State<T>) {
        if !isExistingState(state) {
            states.append(state)
        }
    }
    
    /**
     Adds an array of states to the machine, ignoring those that han been added to the machine already
    */
    public func addStates(states: [State<T>]) {
        self.states.appendContentsOf(states.filter({!isExistingState($0)}))
    }
    
    /**
     Checks if the state machine contains a given event
    */
    public func isExistingEvent(event: Event<T>) -> Bool {
        return events.contains(event)
    }
    
    /**
     Adds an event to the state machine, failing silently if the event had been added already
    */
    public func addEvent(event: Event<T>) {
        if !isExistingEvent(event) {
            events.append(event)
        }
    }
    
    /**
     Adds an array of events to the machine, ignoring those that han been added to the machine already
     */
    public func addEvents(events: [Event<T>]) {
        self.events.appendContentsOf(events.filter({!isExistingEvent($0)}))
    }
    
    /**
     Check if the state machine is currently at a particular state
    */
    public func isInState(state:State<T>) -> Bool {
        return currentState == state 
    }
    
    public func canTransitionTo(state: State<T>) -> Bool {
        guard running && isExistingState(state) else {
            return false
        }
        
        let posibleEvents = events.filter({[unowned self] event in event.sourceStates.contains(self.currentState) })
        for transition in posibleEvents {
            if transition.destinationState == state {
                return true
            }
        }

        return false
    }
    
    public func canFireEvent(event: Event<T>) -> Bool {
        guard running && isExistingEvent(event) else {
            return false
        }
        return event.sourceStates.contains(currentState)
    }
    
    private func checkMachineIntegrity() -> Bool {
        return checkStateCount() && checkEventCount() && checkEventsIntegrity()
    }
    
    private func checkEventsIntegrity() -> Bool {
        return events.map({[unowned self] event in self.checkEventIntegrity(event)}).reduce(true){(sum, next) in return sum && next}
    }
    
    private func checkEventIntegrity(event: Event<T>) -> Bool {
        let sourceStates = event.sourceStates
        let destinationState = event.destinationState
        
        return isExistingState(destinationState) && checkStatesIntegrity(sourceStates)
    }
    
    private func checkStatesIntegrity(states: [State<T>]) -> Bool {
        return states.map({[unowned self] state in self.isExistingState(state)}).reduce(true){(sum, next) in return sum && next}
    }
    
    private func checkStateCount() -> Bool {
        return states.count != 0
    }
    
    private func checkEventCount() -> Bool {
        return events.count != 0
    }
    
    /**
     Starts the state machine. Returns a boolean that indicates if the machine is running.
    */
    public func start() -> Bool {
        running = checkMachineIntegrity()
        if running {
            activateState(currentState)
        }
        return running
    }
    
    /**
     Indicates if the machine is running
    */
    public func isRunning() -> Bool {
        return running
    }
    
    /**
     Fire an event. Returns the result of the event.
    */
    public func fireEvent(event: Event<T>) -> Transition {
        if !running || !checkEventIntegrity(event) {
            return .Inconsistent
        }
        
        return fireEventByName(event.name)
    }
    
    /**
     Fire an event. Returns the result of the event.
     */
    private func fireEventByName(eventName: String) -> Transition {
        if let event = eventWithName(eventName) {
            let sourceStates = event.sourceStates
            let destinationState = event.destinationState
            
            if sourceStates.contains(currentState){
                activateState(destinationState)
                
                return .Completed
            }
            
            return .Inconsistent
        } else {
            return .Declined
        }
    }
    
    /**
     Returns an event as an optional
    */
    private func eventWithName(name: String) -> Event<T>? {
        return events.filter { (element) -> Bool in
            return element.name == name
            }.first
    }
    
    private func activateState(state: State<T>) {
        state.willEnterState?(finalState: state)
        currentState.willExitState?(initialState: currentState)

        let oldState = stateWithValue(currentState.value)
        
        currentState = state
        
        currentState.didEnterState?(finalState: currentState)
        oldState?.didExitState?(initialState: oldState!)
    }
    
    private func stateWithValue(value: T) -> State<T>? {
        return states.filter { (element) -> Bool in
            return element.value == value
            }.first
    }
    
}