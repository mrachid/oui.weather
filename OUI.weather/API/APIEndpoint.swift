//
//  APIEndpoint.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 08/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation
import Moya


enum APIEndpoints {
    case getWeatherCityForFiveDays(lat: Double, lon: Double)
    case getWeatherCurrentLocation(lat: Double, lon: Double)
    case getCurentWeatherCity(cityName: String)
}

extension APIEndpoints: TargetType {
    var baseURL: URL {
        return Constants.Base.url!
    }
    
    var path: String {
        switch self {
        case .getWeatherCityForFiveDays(_, _):
            return "forecast"
        case .getCurentWeatherCity(_), .getWeatherCurrentLocation(_,_):
            return "weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherCityForFiveDays, .getCurentWeatherCity, .getWeatherCurrentLocation:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getWeatherCityForFiveDays(let lat, let lon), .getWeatherCurrentLocation(let lat, let lon):
            let params = ["units": "metric", "lat": lat, "lon": lon, "appid": Constants.keyAPI.weatherKey] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getCurentWeatherCity(let cityName):
            let params = ["units": "metric", "q": cityName, "appid": Constants.keyAPI.weatherKey]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return nil
    }
}

