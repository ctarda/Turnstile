//
//  State.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 09/05/15.
//

import Foundation

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