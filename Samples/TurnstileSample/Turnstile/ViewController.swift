//
//  ViewController.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 06/06/2015.
//

import UIKit

class ViewController: UIViewController, RegularDayObserver {
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var ringAlarmButton: UIButton!
    @IBOutlet weak var brewTeaButton: UIButton!
    @IBOutlet weak var goToWorkButton: UIButton!
    @IBOutlet weak var fleeOfficeButton: UIButton!
    
    private final lazy var myDay: RegularDay = {
        return RegularDay(observer: self)
    }()
    
    @IBAction func ringAlarm() {
        myDay.getUp()
    }
    
    @IBAction func brewTea() {
        myDay.brewTea()
    }
    
    @IBAction func goToWork() {
        myDay.goToWork()
    }
    
    @IBAction func fleeOffice() {
        myDay.fleeOffice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDay.start()
    }
    
    func newEvent(message: String) {
        status?.text = message
        ringAlarmButton?.isEnabled = myDay.canGetUp()
        brewTeaButton?.isEnabled = myDay.canBrewTea()
        goToWorkButton?.isEnabled = myDay.canGoToWork()
        fleeOfficeButton?.isEnabled = myDay.canFleeOffice()
    }
}

