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

    private(set) final public var value: T
    
    final public var willEnterState: ((finalState : State<T>) -> Void)?
    final public var didEnterState: ((finalState : State<T>) -> Void)?
    final public var willExitState: ((initialState : State<T>) -> Void)?
    final public var didExitState: ((initialState : State<T>) -> Void)?
    
    public init(value: T) {
        self.value = value
    }
}

extension State: Equatable {}

public func ==<T>(lhs:State<T>,rhs:State<T>) -> Bool {
    return (lhs.value == rhs.value)
}