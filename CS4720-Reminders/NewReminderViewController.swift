//
//  NewReminderViewController.swift
//  CS4720-Reminders
//
//  Created by Guanmei Liang on 2/20/16.
//  Copyright © 2016 Guanmei Liang. All rights reserved.
//

import UIKit

class NewReminderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dateTimeLabel.minimumDate = NSDate().dateByAddingTimeInterval(60)
        
        if let r = reminder {
            self.title = "Edit Reminder"
            titleLabel.text = r.title
            descriptionLabel.text = r.description
            dateTimeLabel.date = r.date
        } else {
            self.title = "New Reminder"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var reminder: Reminder?
    
    // MARK: - Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    //called before navigation to another view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // when save button is pressed
        if saveButton === sender {
            let title = titleLabel.text ?? ""
            let description = descriptionLabel.text ?? ""
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.FullStyle
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle

            let date = dateTimeLabel.date
            let dateString = formatter.stringFromDate(date)
            
            //passes this reminder object back to previous view
            reminder = Reminder(title: title, description: description, dateTime: dateString, date: date)
            
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let reminderDate = dateTimeLabel.date
        let currentDate = NSDate()
        if currentDate.compare(reminderDate) != NSComparisonResult.OrderedAscending {
            let alertController = UIAlertController(title: "This time has already passed!", message: "Please choose a time in the future.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
            dateTimeLabel.minimumDate = NSDate().dateByAddingTimeInterval(60)
            return false
        }
        return true
    }
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var dateTimeLabel: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: Actions

}
