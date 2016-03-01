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

	/**
		The event name. Read-only
	*/
    private(set) public final var name: String
	
	/**
		Source States this event can trigger a transtion from. Read-only
	*/	
    private(set) public final var sourceStates: [State<T>]
	
	/**
		The destination State. Read-only
	*/	
    private(set) public final var destinationState: State<T>
    
	/**
		Creates a new event
	*/	
    public init(name: String, sourceStates source: [State<T>], destinationState destination: State<T>) {
        self.name = name
        self.sourceStates = source
        self.destinationState = destination
    }
}

extension Event: Equatable {}
/**
	Event comparison. Two events are equal if they have the same name, the same Source States and 
	the same Destination State
*/
public func ==<T>(lhs:Event<T>,rhs:Event<T>) -> Bool {
    return (lhs.name == rhs.name) && (lhs.sourceStates == rhs.sourceStates) && (lhs.destinationState == rhs.destinationState)
}
