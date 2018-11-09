//
//  InfoViewController.swift
//  All Day Agenda
//
//  Created by Nathan Lorenz on 2018-11-08.
//  Copyright © 2018 Nathan Lorenz. All rights reserved.
//

import UIKit
import CoreData

class InfoViewController: UIViewController {
    
    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var priorityOutlet: UILabel!
    @IBOutlet weak var descriptionOutlet: UITextView!
    @IBOutlet weak var gotItOutlet: UIButton!
    
    var titleName = ""
    var priorityType = ""
    var descriptionText = ""
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        gotItOutlet.layer.cornerRadius = 10
        viewOutlet.layer.cornerRadius = 10
        
        if priorityType == "Low"
        {
            priorityOutlet.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        }
        if priorityType == "Medium"
        {
            priorityOutlet.textColor = UIColor.orange
        }
        if priorityType == "High"
        {
            priorityOutlet.textColor = UIColor.red
        }
        else
        {
            priorityOutlet.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
            priorityType = "Low"
        }
        
        
        titleOutlet.text = "\(titleName)"
        priorityOutlet.text = "\(priorityType)"
        descriptionOutlet.text = "\(descriptionText)"
        
    }
    
    @IBAction func gotItAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    

}
