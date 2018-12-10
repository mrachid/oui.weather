//
//  DateHelper.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 09/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation

class DateHelper {
        
    //32/10/2017
    static let dateShortFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        return dateFormater
    }()
    
    //Sunday, Dec 9, 2018
    static let dateCompleteFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.setLocalizedDateFormatFromTemplate("EEEE, MMM d, yyyy")
        
        return dateFormater
    }()
    
    //06:00 AM
    static let dateTimeShortFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.setLocalizedDateFormatFromTemplate("h:mm a")
        
        return dateFormater
    }()
}
