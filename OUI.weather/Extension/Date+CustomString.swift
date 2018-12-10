//
//  Date+CustomString.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 09/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation

public extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: customString) ?? Date()
    }
}
