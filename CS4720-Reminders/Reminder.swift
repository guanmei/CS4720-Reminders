//
//  Reminder.swift
//  CS4720-Reminders
//
//  Created by Guanmei Liang on 2/20/16.
//  Copyright © 2016 Guanmei Liang. All rights reserved.
//

import UIKit

class Reminder {
    // MARK: Properties
    
    var title: String
    var description: String?
    var dateTime: String
    var date: NSDate
    
    // MARK: Initialization
    init?(title: String, description: String?, dateTime: String, date: NSDate){
        self.title = title
        self.description = description
        self.dateTime = dateTime
        self.date = date
        
        if title.isEmpty {
            return nil
        }
    }
}
