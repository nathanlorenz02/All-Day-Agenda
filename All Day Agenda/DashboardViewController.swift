//
//  DashboardViewController.swift
//  All Day Agenda
//
//  Created by Nathan Lorenz on 2017-08-20.
//  Copyright © 2017 Nathan Lorenz. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberOfEventsLbl: UILabel!
    @IBOutlet weak var highPriorityLbl: UILabel!
    @IBOutlet weak var setRemindersLbl: UILabel!
    
    
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func menuButton(_ sender: Any)
    {
        if (menuShowing)
        {
            leadingConstraint.constant = -200
            
            UIView.animate(withDuration: 0.2, animations: {self.view.layoutIfNeeded()})
        }else
        {
            
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    @IBAction func hideMenuSwipe(_ sender: UISwipeGestureRecognizer)
    {
        if (menuShowing)
        {
            leadingConstraint.constant = -200
            UIView.animate(withDuration: 0.2, animations: {self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    
}
