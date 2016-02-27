//
//  Event.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 09/05/15.
//

import Foundation
/**
 Events trigger _transitions_ from one _state_ to another. Events link source states with and destination state.
*/
public class Event <T:Hashable> {
    
    private(set) public final var name: String
    private(set) public final var sourceStates: [State<T>]
    private(set) public final var destinationState: State<T>
    
    public init(name: String, sourceStates source: [State<T>], destinationState destination: State<T>) {
        self.name = name
        self.sourceStates = source
        self.destinationState = destination
    }
}

extension Event: Equatable {}

public func ==<T>(lhs:Event<T>,rhs:Event<T>) -> Bool {
    return (lhs.name == rhs.name) && (lhs.sourceStates == rhs.sourceStates) && (lhs.destinationState == rhs.destinationState)
}
