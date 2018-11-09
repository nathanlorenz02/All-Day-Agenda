//
//  ViewController.swift
//  All Day Agenda
//
//  Created by Nathan Lorenz on 2017-08-20.
//  Copyright © 2017 Nathan Lorenz. All rights reserved.
//

import UIKit
import CoreData




class customTableView: UITableViewCell {
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var notesText: UILabel!
    @IBOutlet weak var priorityText: UILabel!
    
    @IBOutlet weak var view2: UIView!
    

}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var emptyAgenda: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var titleName: [NSManagedObject] = []
    var descriptionName: [NSManagedObject] = []
    var priorityName: [NSManagedObject] = []
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return titleName.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let name = titleName[indexPath.row]
        let description = descriptionName[indexPath.row]
        let priority = priorityName[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customTableView
        cell.titleText?.text = name.value(forKey: "name") as? String
        cell.notesText?.text = description.value(forKey: "descriptionText") as? String
        cell.priorityText?.text = priority.value(forKey: "priority") as? String
        
        if cell.priorityText.text == "High"
        {
            cell.priorityText.textColor = UIColor.red
        }
        if cell.priorityText.text == "Medium"
        {
            cell.priorityText.textColor = UIColor.orange
        }
        if cell.priorityText.text == "Low"
        {
            //Color already set to green
        }
       
        
        
        cell.view2.layer.cornerRadius = 20
       
        return cell
        
        
    }

    

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            
        }
        
        navigationItem.hidesBackButton = true
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if titleName.count == 0
        {
            tableView.isHidden = true
        }
        if titleName.count > 0
        {
            tableView.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Name")
        let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "Description")
        let fetchRequest3 = NSFetchRequest<NSManagedObject>(entityName: "Priority")
        
        do
        {
            titleName = try context.fetch(fetchRequest)
            descriptionName = try context.fetch(fetchRequest2)
            priorityName = try context.fetch(fetchRequest3)
        }
        catch
        {
            print("Unable to fetch")
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        tableView.reloadData()
        
        if titleName.count > 0
        {
            tableView.isHidden = false
        }
        
        
    }
    
   
    
    //Delete item
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(titleName[indexPath.row])
            context.delete(descriptionName[indexPath.row])
            context.delete(priorityName[indexPath.row])
            
            titleName.remove(at: indexPath.row)
            descriptionName.remove(at: indexPath.row)
            priorityName.remove(at: indexPath.row)
            
            do
            {
                try context.save()
            }
            catch
            {
                print("Error: Unable to delete item")
            }
            self.tableView.reloadData()
            if titleName.count == 0
            {
                tableView.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var title2 = String()
        var priority2 = String()
        var description2 = String()
        
        tableView.deselectRow(at: indexPath, animated: true)

        let title = titleName[indexPath.row]
        title2 = (title.value(forKeyPath: "name") as? String)!
        
        let priority = priorityName[indexPath.row]
        priority2 = (priority.value(forKeyPath: "priority") as? String)!
        
        let description = descriptionName[indexPath.row]
        description2 = (description.value(forKeyPath: "descriptionText") as? String)!
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "showInfo") as! InfoViewController
        infoVC.titleName = title2
        infoVC.priorityType = priority2
        infoVC.descriptionText = description2
        self.present(infoVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}



