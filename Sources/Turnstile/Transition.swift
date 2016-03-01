//
//  Transition.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 14/05/15.
//

/**
    Enumerates the posible results of an event.
*/
public enum Transition {
	/**
		The Event completed successfully
	*/
    case Completed    
	/**
		The Event was declined by the State Machine because
		The State Machine could not find this Event registered with it.
	*/
    case Declined
	/**
		The State Machine is in an State that is not registered as a
		Source State with the Event.
	*/
    case Inconsistent
}