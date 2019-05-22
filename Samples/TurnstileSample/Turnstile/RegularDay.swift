//
//  RegularDay.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 06/06/15.
//

import Foundation
import UIKit

import Turnstile

public protocol RegularDayObserver {
    func newEvent(message: String)
}

final class RegularDay {
    
    private struct States {
        static let sleepState = State(value: "Sleeping")
        static let grumpyNotSleepingButYetNotAwake = State(value: "Before morning tea")
        static let notSoGrumpyAndAwake = State(value: "After morning tea")
        static let totallyGrumpy = State(value: "Working")
        static let totallyHappyLifeIsAwesome = State(value: "Slo-mo beach running")
    }
    
    private struct Transitions {
        static let alarmRings = Event(name: "The Bloogy Thing that rings is triggered", sourceStates: [States.sleepState], destinationState: States.grumpyNotSleepingButYetNotAwake)
        static let teaIsReady = Event(name: "Mmmm, tea", sourceStates: [States.grumpyNotSleepingButYetNotAwake], destinationState: States.notSoGrumpyAndAwake)
        static let timeToLeaveForWork = Event(name: "💩💩💩💩", sourceStates: [States.notSoGrumpyAndAwake], destinationState: States.totallyGrumpy)
        static let timeToPlay = Event(name: "🌸☀️🏄🏻🏊🏼🏂💃🏻", sourceStates: [States.totallyGrumpy], destinationState: States.totallyHappyLifeIsAwesome)
        
    }
    
    let observer: RegularDayObserver
    let stateMachine: StateMachine<String>
    
    init(observer: RegularDayObserver) {
        self.observer = observer
        stateMachine = StateMachine(initialState: States.sleepState, states: [States.grumpyNotSleepingButYetNotAwake, States.notSoGrumpyAndAwake, States.totallyGrumpy, States.totallyHappyLifeIsAwesome])
        
        setupStateMachine()
    }
    
    private func setupStateMachine() {
        stateMachine.addEvents([Transitions.alarmRings, Transitions.teaIsReady, Transitions.timeToLeaveForWork, Transitions.timeToPlay])
        
        States.sleepState.didEnterState = {state in self.observer.newEvent(message: "Zzzzzzzzzzz") }
        States.grumpyNotSleepingButYetNotAwake.didEnterState = {state in self.observer.newEvent(message: "In need my tea...")}
        States.notSoGrumpyAndAwake.didEnterState = {state in self.observer.newEvent(message: "Meh")}
        States.totallyGrumpy.didEnterState = {state in self.observer.newEvent(message: "Android, LOL!")}
        States.totallyHappyLifeIsAwesome.didEnterState = {state in self.observer.newEvent(message: "Oh, look! A unicorn!")}
    }
    
    func start() {
        let _ = stateMachine.start()
    }
    
    func canGetUp() -> Bool {
        return stateMachine.canFireEvent(Transitions.alarmRings)
    }

    func getUp() {
        let _ = stateMachine.fireEvent(Transitions.alarmRings)
    }
    
    func canBrewTea() -> Bool {
        return stateMachine.canFireEvent(Transitions.teaIsReady)
    }
    
    func brewTea() {
        let _ = stateMachine.fireEvent(Transitions.teaIsReady)
    }
    
    func canGoToWork() -> Bool {
        return stateMachine.canFireEvent(Transitions.timeToLeaveForWork)
    }
    
    func goToWork() {
        let _ = stateMachine.fireEvent(Transitions.timeToLeaveForWork)
    }
    
    func canFleeOffice() -> Bool {
        // Can determine if an event could be fire using the destination State<T> as argument
        return stateMachine.canTransitionTo(States.totallyHappyLifeIsAwesome)
    }
    
    func fleeOffice() {
        let _ = stateMachine.fireEvent(Transitions.timeToPlay)
    }
}
