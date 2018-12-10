//
//  Logger.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 08/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation

final class Logger {
    
    private init() {}
    
    public static func log(success: Bool = false, message: String, file: String = #file, line: Int = #line, function: String = #function) {
        if success {
            print("\(file) - \(line): \(function) - \(message)")
        } else {
            print("❌ \(file) - \(line): \(function) - Error: \(message) ❌")
        }
    }
    
    public static func log(success: Bool = false, file: String = #file, line: Int = #line, function: String = #function, object: AnyObject) {
        if success {
            print("\(file) - \(line): \(function) - \(object)")
        } else {
            print("❌ \(file) - \(line): \(function) - Error: \(object) ❌")
        }
    }
    
    public static func log(success: Bool = false, message: String, file: String = #file, line: Int = #line, function: String = #function, object: Any) {
        if success {
            print("\(file) - \(line): \(function) - \(object)")
        } else {
            print("❌ \(file) - \(line): \(function) - Error: \(object) ❌")
        }
    }
}
