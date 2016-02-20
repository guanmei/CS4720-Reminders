//
//  ViewController.swift
//  CS4720-Reminders
//
//  Created by Guanmei Liang on 2/19/16.
//  Copyright © 2016 Guanmei Liang. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // MARK: Properties
    var reminders = [Reminder]()

    // MARK: Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // returns number of reminders in the table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ReminderTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell
        let reminder = reminders[indexPath.row]
        cell.titleLabel.text = reminder.title
        cell.descriptionLabel.text = reminder.description
        
        return cell
    }

    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewReminderViewController, reminder = sourceViewController.reminder {
            let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
                reminders.append(reminder)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
}

