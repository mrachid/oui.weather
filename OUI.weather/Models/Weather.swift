//
//  Weather.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 08/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation

//MARK: - TEMP
struct WeatherTemp {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
}


extension WeatherTemp: Decodable {
    
    enum WeatherTempKeys: String, CodingKey {

        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherTempKeys.self)
        
        temp = try container.decode(Double.self, forKey: .temp)
        tempMin = try container.decode(Double.self, forKey: .tempMin)
        tempMax = try container.decode(Double.self, forKey: .tempMax)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try container.decode(Double.self, forKey: .humidity)   
    }
}

//MARK: - INFO
struct WeatherInfo {
    let mainDescription: String
    let mainInfo: String
    let icon: String
}


extension WeatherInfo: Decodable {
    
    enum WeatherInfoKeys: String, CodingKey {
        case mainDescription = "description"
        case mainInfo = "main"
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherInfoKeys.self)
        mainDescription = try container.decode(String.self, forKey: .mainDescription)
        mainInfo = try container.decode(String.self, forKey: .mainInfo)
        icon = try container.decode(String.self, forKey: .icon)
    }
}
//MARK: - WIND
struct WeatherWind {
    let speed: Double
    let deg: Double
}

extension WeatherWind: Decodable {
    
    enum WeatherWindKeys: String, CodingKey {
        
        case speed
        case deg
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherWindKeys.self)
        
        speed = try container.decode(Double.self, forKey: .speed)
        deg = try container.decode(Double.self, forKey: .deg)
    }
}
//MARK: - WEATHER
struct Weather {
    let time: Double
    let date: Date
    let temp: WeatherTemp
    let info: [WeatherInfo]
    let wind: WeatherWind
}

extension Weather: Decodable {
    
    enum WeatherKeys: String, CodingKey {
        case time = "dt"
        case date = "dt_txt"
        case temp = "main"
        case info = "weather"
        case wind
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherKeys.self)
        
        time = try container.decode(Double.self, forKey: .time)
        temp = try container.decode(WeatherTemp.self, forKey: .temp)
        info = try container.decode([WeatherInfo].self, forKey: .info)
        wind = try container.decode(WeatherWind.self, forKey: .wind)
        let infoDate = try container.decode(String.self, forKey: .date)
        date = Date.dateFromCustomString(customString: infoDate)
    }
}

//MARK: - WEATHERLIST
struct WeatherList {
    let city: City
    let weathers: [Weather]
}

extension WeatherList: Decodable {
    
    enum WeatherListKeys: String, CodingKey {
        case city
        case weathers = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherListKeys.self)
        
        city = try container.decode(City.self, forKey: .city)
        weathers = try container.decode([Weather].self, forKey: .weathers)
    }
}

