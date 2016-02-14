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
    
    @IBAction func ringAlarm(sender: AnyObject) {
        myDay.getUp()
    }
    
    @IBAction func brewTea(sender: AnyObject) {
        myDay.brewTea()
    }
    
    @IBAction func goToWork(sender: AnyObject) {
        myDay.goToWork()
    }
    
    @IBAction func fleeOffice(sender: AnyObject) {
        myDay.fleeOffice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDay.start()
    }
    
    func newEvent(message: String) {
        status?.text = message
        ringAlarmButton?.enabled = myDay.canGetUp()
        brewTeaButton?.enabled = myDay.canBrewTea()
        goToWorkButton?.enabled = myDay.canGoToWork()
        fleeOfficeButton?.enabled = myDay.canFleeOffice()
    }
}

