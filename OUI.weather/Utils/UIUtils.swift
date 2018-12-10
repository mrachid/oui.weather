//
//  UIUtils.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 09/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit

final class UIUtils {
    
    private init() {
    }
    
    static func presentOkAlert(controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
