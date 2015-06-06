//
//  RegularDay.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 06/06/15.
//

import Foundation

import Turnstile

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
    
    let feedbackLabel: UILabel
    let stateMachine: StateMachine<String>
    
    init(feedbackLabel: UILabel) {
        self.feedbackLabel = feedbackLabel
        stateMachine = StateMachine(initialState: States.sleepState, states: [States.grumpyNotSleepingButYetNotAwake, States.notSoGrumpyAndAwake, States.totallyGrumpy, States.totallyHappyLifeIsAwesome])
        
        setupStateMachine()
    }
    
    private func setupStateMachine() {
        stateMachine.addEvents([Transitions.alarmRings, Transitions.teaIsReady, Transitions.timeToLeaveForWork, Transitions.timeToPlay])
        
        States.sleepState.didEnterState = {state in self.feedbackLabel.text = "Zzzzzzzzzzz"}
        States.grumpyNotSleepingButYetNotAwake.didEnterState = {state in self.feedbackLabel.text = "In need my tea..."}
        States.notSoGrumpyAndAwake.didEnterState = {state in self.feedbackLabel.text = "Meh"}
        States.totallyGrumpy.didEnterState = {state in self.feedbackLabel.text = "Android, LOL!"}
        States.totallyHappyLifeIsAwesome.didEnterState = {state in self.feedbackLabel.text = "Oh, look! A unicorn!"}
    }
    
    func start() {
        stateMachine.start()
    }
    
    func getUp() {
        stateMachine.fireEvent(Transitions.alarmRings)
    }
    
    func brewTea() {
        stateMachine.fireEvent(Transitions.teaIsReady)
    }
    
    func goToWork() {
        stateMachine.fireEvent(Transitions.timeToLeaveForWork)
    }
    
    func fleeOffice() {
        stateMachine.fireEvent(Transitions.timeToPlay)
    }
}