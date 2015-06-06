//
//  ViewController.swift
//  Turnstile
//
//  Created by Cesar Tardaguila on 06/06/2015.
//  Copyright (c) 06/06/2015 Cesar Tardaguila. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var status: UILabel!
    
    private final lazy var myDay: RegularDay = {
        return RegularDay(feedbackLabel: self.status)
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
}

