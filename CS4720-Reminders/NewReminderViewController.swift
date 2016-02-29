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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var reminder: Reminder?
    
    // MARK: - Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
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
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var dateTimeLabel: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: Actions

}
