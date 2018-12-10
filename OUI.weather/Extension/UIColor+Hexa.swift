//
//  Color+Extension.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 07/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexa: String) {
        let hex = hexa.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanLocation = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }
}
