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
        //navigationItem.leftBarButtonItem = editButtonItem()
        reminders.sortInPlace({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ReminderTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell
        let reminder = reminders[indexPath.row]
        cell.titleLabel.text = reminder.title
        cell.dateLabel.text = reminder.dateTime
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            reminders.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let remDetailViewCtrl = segue.destinationViewController as! NewReminderViewController
            if let selectedCell = sender as? ReminderTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedReminder = reminders[indexPath.row]
                remDetailViewCtrl.reminder = selectedReminder
            }
        }
    }

    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewReminderViewController, reminder = sourceViewController.reminder {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                reminders[selectedIndexPath.row] = reminder
                // Not necessary with the reload at the end?
                //tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
                reminders.append(reminder)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            reminders.sortInPlace({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
            tableView.reloadData()
        }
    }
}

