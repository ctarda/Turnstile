//
//  StateMachine.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 10/05/15.
//

import Foundation

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
        self.states.extend(states)
    }
    
    public func isExistingState(state: State<T>) -> Bool {
        return contains(states, state)
    }
    
    public func addState(state: State<T>) {
        if !isExistingState(state) {
            states.append(state)
        }
    }
    
    public func addStates(states: [State<T>]) {
        self.states.extend(states.filter({!contains(self.states, $0)}))
    }
    
    public func isExistingEvent(event: Event<T>) -> Bool {
        return contains(events, event)
    }
    
    public func addEvent(event: Event<T>) {
        if !isExistingEvent(event) {
            events.append(event)
        }
    }
    
    public func addEvents(events: [Event<T>]) {
        self.events.extend(events.filter({!contains(self.events, $0)}))
    }
    
    public func isInState(state:State<T>) -> Bool {
        return currentState == state 
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
        
        let isValidSource = checkStatesIntegrity(sourceStates)
        let isValidDestination = isExistingState(destinationState)
        
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
    
    public func start() -> Bool {
        running = checkMachineIntegrity()
        if running {
            activateState(currentState)
        }
        return running
    }
    
    public func isRunning() -> Bool {
        return running
    }
    
    public func fireEvent(event: Event<T>) -> Transition {
        if !running || !checkEventIntegrity(event) {
            return .Inconsistent
        }
        
        return fireEventByName(event.name)
    }
    
    private func fireEventByName(eventName: String) -> Transition {
        if let event = eventWithName(eventName) {
            let sourceStates = event.sourceStates
            let destinationState = event.destinationState
            
            if contains(sourceStates, currentState){
                activateState(destinationState)
                
                return .Completed
            }
            
            return .Inconsistent
        } else {
            return .Declined
        }
    }
    
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