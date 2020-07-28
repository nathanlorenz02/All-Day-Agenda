//
//  SettingsViewController.swift
//  All Day Agenda
//
//  Created by Nathan Lorenz on 2017-08-20.
//  Copyright © 2017 Nathan Lorenz. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices
import UserNotifications



class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var reportButtonLabel: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        navigationItem.hidesBackButton = true
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        reportButtonLabel.layer.cornerRadius = 10


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @objc func configuredMailComposeViewController() -> MFMailComposeViewController
    {
        let systemVersion = UIDevice.current.systemVersion
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8 , value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        mailComposeVC.setToRecipients(["allswiftdeveloper@gmail.com"])
        mailComposeVC.setSubject("Reported Problem - All Day Agenda")
        mailComposeVC.setMessageBody("System Information\n\n iOS \(systemVersion) \n \(identifier) \n Version 1.0.0 \n\n Hi Team!\n\n", isHTML: false)
        
        return mailComposeVC
    }
    
    @objc func showSendMailErrorAlert()
    {
        let alert = UIAlertController(title: "Could Not Send Mail", message: "Unable to send email. Please check your email configuration, and try again.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        switch result {
        case MFMailComposeResult.cancelled:
            self.dismiss(animated: true, completion: nil)
        case MFMailComposeResult.failed:
            self.showSendMailErrorAlert()
            self.dismiss(animated: true, completion: nil)
        case MFMailComposeResult.sent:
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
        
        
   
    }

 
    @IBAction func reportProblemButton(_ sender: Any)
    {
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail()
        {
            self.present(mailComposeViewController, animated: true)
        }
        else
        {
            self.showSendMailErrorAlert()
        }
    }
    
   
    
    @IBAction func infoNotification(_ sender: Any)
    {
        let alert = UIAlertController(title: "Your Repeated Notification", message: "You will receive a notification a 9:00AM every day to remind you to check your agenda.", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)

    }

    
}
