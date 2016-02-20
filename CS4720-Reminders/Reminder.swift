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
    
    // MARK: Initialization
    init?(title: String, description: String?) {
        self.title = title
        self.description = description
        
        if title.isEmpty {
            return nil
        }
    }
}
