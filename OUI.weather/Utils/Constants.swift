//
//  Constants.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 07/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit

struct Constants {
    private init(){}
    
    struct Base {
        static let url = URL(string: "https://api.openweathermap.org/data/2.5")
    }
    
    struct keyAPI {
        static let weatherKey = "fc5a9cfda7353595b953b72bd90ca127"
        static let googleKey = "AIzaSyAi5co7tb1RfZ4Ej6sZUDzIFU2XN20-8o8"
    }
    
    struct Colors {
        static let blueNight = UIColor.init(hexa: "#16273A")
        static let blueGray = UIColor.init(hexa: "#263747")
    }
    
    struct iconImage {
        static let icons = [
            iconOpenWeatherMap.iconOneD.rawValue: UIImage(named: "sun"),
            iconOpenWeatherMap.iconTwoD.rawValue: UIImage(named: "cloudy"),
            iconOpenWeatherMap.iconThreeD.rawValue: UIImage(named: "cloud"),
            iconOpenWeatherMap.iconFourD.rawValue: UIImage(named: "cloud"),
            iconOpenWeatherMap.iconFiveD.rawValue: UIImage(named: "rainy"),
            iconOpenWeatherMap.iconSixD.rawValue: UIImage(named: "rainy"),
            iconOpenWeatherMap.iconSevenD.rawValue: UIImage(named: "thunder"),
            iconOpenWeatherMap.iconEightD.rawValue: UIImage(named: "snowy"),
            iconOpenWeatherMap.iconNineD.rawValue: UIImage(named: "wind"),
            iconOpenWeatherMap.iconOneN.rawValue: UIImage(named: "moon"),
            iconOpenWeatherMap.iconTwoN.rawValue: UIImage(named: "cloudy"),
            iconOpenWeatherMap.iconThreeN.rawValue: UIImage(named: "cloud"),
            iconOpenWeatherMap.iconFourN.rawValue: UIImage(named: "cloud"),
            iconOpenWeatherMap.iconFiveN.rawValue: UIImage(named: "rainy"),
            iconOpenWeatherMap.iconSixN.rawValue: UIImage(named: "rainy"),
            iconOpenWeatherMap.iconSevenN.rawValue: UIImage(named: "thunder"),
            iconOpenWeatherMap.iconEightN.rawValue: UIImage(named: "snowy"),
            iconOpenWeatherMap.iconNineN.rawValue: UIImage(named: "wind"),
            ]
    }
    
    enum iconOpenWeatherMap: String {
        case iconOneD = "01d"
        case iconTwoD = "02d"
        case iconThreeD = "03d"
        case iconFourD = "04d"
        case iconFiveD = "09d"
        case iconSixD = "10d"
        case iconSevenD = "11d"
        case iconEightD = "13d"
        case iconNineD = "50d"
        case iconOneN = "01n"
        case iconTwoN = "02n"
        case iconThreeN = "03n"
        case iconFourN = "04n"
        case iconFiveN = "09n"
        case iconSixN = "10n"
        case iconSevenN = "11n"
        case iconEightN = "13n"
        case iconNineN = "50n"
    }
    
    struct weatherInfoWord {
        static let word = [
            someWord.clear.rawValue: "It is rather hot, to go out in t shirt is rather a good advice",
            someWord.rain.rawValue: "It is raining! It's better to go out with your umbrella",
            someWord.drizzle.rawValue: "There is a lot of mist being careful if you drive",
            someWord.thunderstorm.rawValue: "Thor is booming now, be careful he must be angry",
            someWord.snow.rawValue: "Wow, it's snowing! we already hear the end of year gifts and holidays",
            someWord.clouds.rawValue: "A little cloudy right now",
            someWord.atmosphere.rawValue: "A little wind, you have to wear a coat",
            someWord.mist.rawValue: "A little wind, you have to wear a coat",
            ]
    }
    enum someWord: String {
        case clear = "Clear"
        case rain = "Rain"
        case drizzle = "Drizzle"
        case thunderstorm = "Thunderstorm"
        case snow = "Snow"
        case clouds = "Clouds"
        case atmosphere = "Atmosphere"
        case mist = "Mist"
    }
}
