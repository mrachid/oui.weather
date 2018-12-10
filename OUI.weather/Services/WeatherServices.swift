//
//  WeatherServices.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 09/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation

final class WeatherServices {
    static let shared = WeatherServices()

    private init() {}
    
    func parseWeatherList(weatherList: WeatherList) -> [(key: String, value: [Weather])] {//}[String: [Weather]] {
        var date = DateHelper.dateShortFormater.string(from: Date())
        var temp = [Weather]()
        var weathers: [String : [Weather]] = [:]
        
        for weather in weatherList.weathers {
            let weatherDate = DateHelper.dateShortFormater.string(from: weather.date)
           
            if date == weatherDate {
                temp.append(weather)
            } else {
                temp.append(weather)
                weathers[date] = temp
                temp.removeAll()
                date = weatherDate
            }
        }
        weathers[date] = temp
        
        return weathers.sorted {
            return $0.key < $1.key
        }
    }
}
