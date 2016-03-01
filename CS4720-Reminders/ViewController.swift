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
    var timer: NSTimer!

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
            if indexPath.row == 0 {
                timer.invalidate()
                if reminders.count > 0 {
                    self.timer = NSTimer(fireDate: self.reminders[0].date, interval: 1, target: self, selector: Selector("showAlert"), userInfo: nil, repeats: false)
                    NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: "NSDefaultRunLoopMode")
                }
            }
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
            } else {
                let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
                reminders.append(reminder)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            reminders.sortInPlace({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
            if let timer = timer {
                timer.invalidate()
            }
            timer = NSTimer(fireDate: reminders[0].date, interval: 1, target: self, selector: Selector("showAlert"), userInfo: nil, repeats: false)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: "NSDefaultRunLoopMode")
            tableView.reloadData()
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: reminders[0].title, message: "The time has come!", preferredStyle: .Alert)
        let postponeAction = UIAlertAction(title: "Postpone", style: .Default) { (action) in
            self.reminders[0].date = self.reminders[0].date.dateByAddingTimeInterval(3600)
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.FullStyle
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            self.reminders[0].dateTime = formatter.stringFromDate(self.reminders[0].date)
            self.reminders.sortInPlace({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
            if self.reminders.count > 0 {
                self.timer = NSTimer(fireDate: self.reminders[0].date, interval: 1, target: self, selector: Selector("showAlert"), userInfo: nil, repeats: false)
                NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: "NSDefaultRunLoopMode")
            }
            self.tableView.reloadData()
        }
        alertController.addAction(postponeAction)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
            let path = NSIndexPath(forRow: 0, inSection: 0)
            self.reminders.removeAtIndex(0)
            self.tableView.deleteRowsAtIndexPaths([path], withRowAnimation: .Fade)
            if self.reminders.count > 0 {
                self.timer = NSTimer(fireDate: self.reminders[0].date, interval: 1, target: self, selector: Selector("showAlert"), userInfo: nil, repeats: false)
                NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: "NSDefaultRunLoopMode")
            }
        }
        alertController.addAction(dismissAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}

