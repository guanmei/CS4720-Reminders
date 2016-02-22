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
    
    // MARK: Initialization
    init?(title: String, description: String?, dateTime: String) {
        self.title = title
        self.description = description
        self.dateTime = dateTime
        
        if title.isEmpty {
            return nil
        }
    }
}
