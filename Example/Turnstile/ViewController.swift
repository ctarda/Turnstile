//
//  ViewController.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 06/06/2015.
//  Copyright (c) 06/06/2015 Cesar Tardaguila. All rights reserved.
//

import UIKit
import Turnstile

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let sleepState = State(value: "Sleeping")
        sleepState.didEnterState = {state in println("Zzzzzzzzz")}
        
        let grumpyNotSleepingButYetNotAwake = State(value: "Before morning tea")
        grumpyNotSleepingButYetNotAwake.didEnterState = {state in println("In need my tea...")}
        
        let notSoGrumpyAndAwake = State(value: "After morning tea")
        notSoGrumpyAndAwake.didEnterState = {state in println("Meh")}
        
        let totallyGrumpy = State(value: "Working")
        totallyGrumpy.didEnterState = {state in println("Android, LOL!")}
        
        let totallyHappyLifeIsAwesome = State(value: "Slo-mo beach running")
        totallyHappyLifeIsAwesome.didEnterState = {state in println("Oh, look! A unicorn!")}
        
        let alarmRings = Event(name: "The Bloogy Thing that rings is triggered", sourceStates: [sleepState], destinationState: grumpyNotSleepingButYetNotAwake)
        let teaIsReady = Event(name: "Mmmm, tea", sourceStates: [grumpyNotSleepingButYetNotAwake], destinationState: notSoGrumpyAndAwake)
        let timeToLeaveForWork = Event(name: "💩💩💩💩", sourceStates: [notSoGrumpyAndAwake], destinationState: totallyGrumpy)
        let timeToPlay = Event(name: "🌸☀️🏄🏻🏊🏼🏂💃🏻", sourceStates: [totallyGrumpy], destinationState: totallyHappyLifeIsAwesome)
        
        let cesar = StateMachine(initialState: sleepState, states: [grumpyNotSleepingButYetNotAwake, notSoGrumpyAndAwake, totallyGrumpy, totallyHappyLifeIsAwesome])
        
        cesar.addEvents([alarmRings, teaIsReady, timeToLeaveForWork, timeToPlay])
        
        let machineStarted = cesar.start()
        
        cesar.fireEvent(alarmRings)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

