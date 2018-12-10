//
//  City.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 08/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation

//MARK: - COORDINATE
struct Coordinate {
    let lon: Double
    let lat: Double
}

extension Coordinate: Decodable {
    
    enum CoordinateKeys: String, CodingKey {
        case lat
        case lon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoordinateKeys.self)
        
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
    }
}

//MARK: - CITY
struct City {
    let id: Int
    let name: String
    let coord: Coordinate
    let temp: WeatherTemp?
    let wind: WeatherWind?
    let time: Double?
    let info: [WeatherInfo]?
}

extension City: Decodable {
    
    enum CityKeys: String, CodingKey {
        case id
        case name
        case coord
        case temp = "main"
        case wind
        case time = "dt"
        case info = "weather"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CityKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        coord = try container.decode(Coordinate.self, forKey: .coord)
        temp = try container.decodeIfPresent(WeatherTemp.self, forKey: .temp)
        wind = try container.decodeIfPresent(WeatherWind.self, forKey: .wind)
        time = try container.decodeIfPresent(Double.self, forKey: .time)
        info = try container.decodeIfPresent([WeatherInfo].self, forKey: .info)
    }
}
