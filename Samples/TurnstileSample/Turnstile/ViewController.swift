//
//  ViewController.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 06/06/2015.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var ringAlarmButton: UIButton!
    @IBOutlet weak var brewTeaButton: UIButton!
    @IBOutlet weak var goToWorkButton: UIButton!
    @IBOutlet weak var fleeOfficeButton: UIButton!
    
    private final lazy var myDay: RegularDay = {
        return RegularDay(feedbackLabel: self.status)
    }()
    
    @IBAction func ringAlarm(sender: AnyObject) {
        myDay.getUp()
        refreshUI()
    }
    
    @IBAction func brewTea(sender: AnyObject) {
        myDay.brewTea()
        refreshUI()
    }
    
    @IBAction func goToWork(sender: AnyObject) {
        myDay.goToWork()
        refreshUI()
    }
    
    @IBAction func fleeOffice(sender: AnyObject) {
        myDay.fleeOffice()
        refreshUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDay.start()
        refreshUI()
    }
    
    func refreshUI() {
        ringAlarmButton?.enabled = myDay.canGetUp()
        brewTeaButton?.enabled = myDay.canBrewTea()
        goToWorkButton?.enabled = myDay.canGoToWork()
        fleeOfficeButton?.enabled = myDay.canFleeOffice()
    }
}

