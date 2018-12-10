//
//  NetworkManager.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 08/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import Foundation
import Moya

internal enum APIErrors: Error {
    case wrongCrendential
    case unknownError
    case noConnectivity
    case parseError
}

internal enum APIErrorsCode: Int {
    case noConnectivity = 0
    case parseError
}

struct APIError: LocalizedError {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(error: APIErrors, code: Int) {
        self.title = "error"
        self.code = code
        switch error {
        case .wrongCrendential:
            self._description = "error crendential"
        case .unknownError:
            self._description = "error unknown error"
        case .noConnectivity:
            self._description = "connectivity error"
        default:
            self._description = "Parsing issue"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    lazy var provider = MoyaProvider<APIEndpoints>()
    
    private init() {}
    
    // MARK: - WEATHER
    func getWeatherForFiveDays(latitude lat: Double, longtitude lon: Double, completion:@escaping (WeatherList?, APIError?) -> Void) {
        self.provider.request(.getWeatherCityForFiveDays(lat: lat, lon: lon)) { (result) in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    do {
                        let weathers = try JSONDecoder().decode(WeatherList.self, from: response.data)
                        completion(weathers, nil)
                    } catch let error {
                        completion(nil, APIError(error: .parseError, code: APIErrorsCode.parseError.rawValue))
                        Logger.log(message: error.localizedDescription)
                    }
                case 403:
                    completion(nil, APIError(error: .wrongCrendential, code: response.statusCode))
                default:
                    completion(nil, APIError(error: .unknownError, code: 1))
                    Logger.log(message: "\(response.statusCode)", object: response)
                }
            case let .failure(error):
                Logger.log(message: error.localizedDescription)
                if error.localizedDescription.contains("Internet") {
                    completion(nil, APIError(error: .noConnectivity, code: APIErrorsCode.noConnectivity.rawValue))
                } else {
                    completion(nil, APIError(error: .unknownError, code: 1))
                }
            }
        }
    }
    
    func getWeatherCurrentLocation(latitude lat: Double, longtitude lon: Double, completion:@escaping (City?, APIError?) -> Void) {
        self.provider.request(.getWeatherCurrentLocation(lat: lat, lon: lon)) { (result) in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    do {
                        let city = try JSONDecoder().decode(City.self, from: response.data)
                        completion(city, nil)
                    } catch let error {
                        completion(nil, APIError(error: .parseError, code: APIErrorsCode.parseError.rawValue))
                        Logger.log(message: error.localizedDescription)
                    }
                case 403:
                    completion(nil, APIError(error: .wrongCrendential, code: response.statusCode))
                default:
                    completion(nil, APIError(error: .unknownError, code: 1))
                    Logger.log(message: "\(response.statusCode)", object: response)
                }
            case let .failure(error):
                Logger.log(message: error.localizedDescription)
                if error.localizedDescription.contains("Internet") {
                    completion(nil, APIError(error: .noConnectivity, code: APIErrorsCode.noConnectivity.rawValue))
                } else {
                    completion(nil, APIError(error: .unknownError, code: 1))
                }
            }
        }
    }
    
    func getCurrentWeather(cityName name: String, completion:@escaping (City?, APIError?) -> Void) {
        self.provider.request(.getCurentWeatherCity(cityName: name)) { (result) in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    do {
                        let city = try JSONDecoder().decode(City.self, from: response.data)
                        completion(city, nil)
                    } catch let error {
                        completion(nil, APIError(error: .parseError, code: APIErrorsCode.parseError.rawValue))
                        Logger.log(message: error.localizedDescription)
                    }
                case 403:
                    completion(nil, APIError(error: .wrongCrendential, code: response.statusCode))
                default:
                    completion(nil, APIError(error: .unknownError, code: 1))
                    Logger.log(message: "\(response.statusCode)", object: response)
                }
            case let .failure(error):
                Logger.log(message: error.localizedDescription)
                if error.localizedDescription.contains("Internet") {
                    completion(nil, APIError(error: .noConnectivity, code: APIErrorsCode.noConnectivity.rawValue))
                } else {
                    completion(nil, APIError(error: .unknownError, code: 1))
                }
            }
        }
    }
}
