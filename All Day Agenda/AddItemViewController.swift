//
//  AddItemViewController.swift
//  All Day Agenda
//
//  Created by Nathan Lorenz on 2017-08-20.
//  Copyright © 2017 Nathan Lorenz. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData




class AddItemViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var addItemOutlet: UIButton!
    @IBOutlet weak var notiSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    var selectedPriority: String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priorityTypes[row]
        priorityTextBox.text = selectedPriority
    }
    
    
    
    let priorityTypes = ["Select --", "Low", "Medium", "High"]
    
    
    
    
    //Priority Done Button
    func pickerViewToolBar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddItemViewController.dissmissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        priorityTextBox.inputAccessoryView = toolBar
    }
    
    @objc func dissmissKeyboard()
    {
        view.endEditing(true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Asks for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            if didAllow
            {
                
                
            }
            else
            {
                
                
            }
            
        })
        
        
        createPriorityPicker()
        pickerViewToolBar()
        
        addItemOutlet.layer.cornerRadius = 10
        
        
        navigationItem.hidesBackButton = true

        textField.delegate = self
        titleTextBox.delegate = self
        textField.text = "Item Description"
        textField.textColor = UIColor.lightGray
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        //Done Button on keyobard for keyboards
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        
        
        toolBar.setItems([doneButton], animated: false)
        
        textField.inputAccessoryView = toolBar
        titleTextBox.inputAccessoryView = toolBar
        


        // Do any additional setup after loading the view.
    }
    
    //Priority Picker
    @objc func createPriorityPicker()
    {
        let priorityPicker = UIPickerView()
        priorityPicker.delegate = self
        
        priorityTextBox.inputView = priorityPicker
    }
    
    
    @IBAction func notificationsOn(_ sender: Any)
    {
        if notiSwitch.isOn == true
        {
            datePicker.isEnabled = true
        }
        else
        {
            datePicker.isEnabled = false
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //Textboxes
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var priorityTextBox: UITextField!
    
    
    //Hideing keyboard features
    @objc func textViewDidBeginEditing(_ textView: UITextView)
    {
        textField.text = ""
        if textField.textColor == UIColor.gray
        {
            if traitCollection.userInterfaceStyle == .light {
                 textField.textColor = UIColor.black
            }
            else {
                textView.textColor = UIColor.white
            }
            
        }
        
    }
    
    //Hides Keyboard Toolbar
    @objc func doneClicked()
    {
        view.endEditing(true)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        titleTextBox.resignFirstResponder()
        return true
    }

    
    //Adding functions 
    func addTitle()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Name", in: context)!
        let theName = NSManagedObject(entity: entity, insertInto: context)
        theName.setValue(titleTextBox.text, forKey: "name")
        
        do
        {
            try context.save()
            
            
        }
        catch
        {
            print("Error: Couldn't save title")
        }
    }
    
    func addDescription()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Description", in: context)!
        let theName = NSManagedObject(entity: entity, insertInto: context)
        theName.setValue(textField.text, forKey: "descriptionText")
        
        do
        {
            try context.save()
            
            
        }
        catch
        {
            print("Error: Couldn't save description")
        }
    }
    
    func addPriority()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Priority", in: context)!
        let theName = NSManagedObject(entity: entity, insertInto: context)
        theName.setValue(priorityTextBox.text, forKey: "priority")
        
        do
        {
            try context.save()
            
            
        }
        catch
        {
            print("Error: Couldn't save title")
        }
    }
    
    func addNotification()
    {
        let content = UNMutableNotificationContent()
        content.body = (titleTextBox.text as String?)!
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let yearDate = Int(dateformatter.string(from: self.datePicker.date))
        dateformatter.dateFormat = "MM"
        let monthDate = Int(dateformatter.string(from: self.datePicker.date))
        dateformatter.dateFormat = "dd"
        let dayDate = Int(dateformatter.string(from: self.datePicker.date))
        dateformatter.dateFormat = "HH"
        let hourDate = Int(dateformatter.string(from: self.datePicker.date))
        dateformatter.dateFormat = "mm"
        let minDate = Int(dateformatter.string(from: self.datePicker.date))
        dateComponents.year = yearDate
        dateComponents.month = monthDate
        dateComponents.day = dayDate
        dateComponents.hour = hourDate
        dateComponents.minute = minDate
        
        let uuid = UUID().uuidString
        let notificationIdentifier = titleTextBox.text! + uuid
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "NotiIdentifier", in: context)!
        let theName = NSManagedObject(entity: entity, insertInto: context)
        theName.setValue(notificationIdentifier, forKey: "notiIdentifier")
        
        do
        {
            try context.save()
            
            
        }
        catch
        {
            print("Error: Couldn't save title")
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
    @IBAction func addItemButton(_ sender: Any)
    {
        if notiSwitch.isOn == true
        {
            addNotification()
        }
        else
        {
            //Not adding notfication
        }
        
        //Add Item
        //Title Box
        if (titleTextBox.text != "")
        {
            //Add title
            addTitle()
            
            
        }
        else
        {
            let alert = UIAlertController(title: "Please add a title", message: "Item Title doesn't have any text. Please add a title to continue.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //Description
        if (textField.text != "")
        {
            //Description
            addDescription()
            
        }
        else
        {
            let alert = UIAlertController(title: "Please add a description", message: "Please add a description to continue.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        //Priority
        if priorityTextBox.text == ""
        {
            priorityTextBox.text = "Low"
            
            addPriority()
        }
        else if priorityTextBox.text == "Select --"
        {
            priorityTextBox.text = "Low"
            
            addPriority()
        }
        else if priorityTextBox.text != "Low" && priorityTextBox.text != "Medium" && priorityTextBox.text != "High"
        {
            priorityTextBox.text = "Low"
            
            addPriority()
        }
        else if priorityTextBox.text != ""
        {
            addPriority()
        }
       
        
        
        //Resetting
        titleTextBox.text = nil
        priorityTextBox.text = nil
        if textField.textColor == UIColor.black
        {
            textField.text = "Item Description"
            textField.textColor = UIColor.lightGray
        }
        
      
        
    }
    
    
}
