//
//  State.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 09/05/15.
//

import Foundation
/**
 A state is a description of the status of a system at a given moment in time, while it is waiting to execute a _transition_
*/
public class State <T: Hashable> {
	/**
		The value encapsulated by the State. Read-only
	*/
    private(set) final public var value: T

	/**
		Closure to be called right before the State Machine
		enters a given State
	*/
    final public var willEnterState: ((finalState : State<T>) -> Void)?
	
	/**
		Closure to be called right after the State Machine
		enters a given State
	*/	
    final public var didEnterState: ((finalState : State<T>) -> Void)?
	
	/**
		Closure to be called right before the State Machine
		exits a given State
	*/	
    final public var willExitState: ((initialState : State<T>) -> Void)?
	
	/**
		Closure to be called right after the State Machine
		exists a given State
	*/	
    final public var didExitState: ((initialState : State<T>) -> Void)?
    
    public init(value: T) {
        self.value = value
    }
}

extension State: Equatable {}

/**
	Two States are equal if they hold the same value
*/
public func ==<T>(lhs:State<T>,rhs:State<T>) -> Bool {
    return (lhs.value == rhs.value)
}