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
            let title = titleLabel.text!
            let description = descriptionLabel.text ?? ""
            
            //passes this reminder object back to previous view
            reminder = Reminder(title: title, description: description)
            
        }
    }
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var dateTimeLabel: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: Actions

}
