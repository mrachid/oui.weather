//
//  WeatherDetailInfoTableViewCell.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 07/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit

class WeatherDetailInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var someInfoLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var speedWindLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    func configure(weather: Weather, city: City) {
        weatherIcon.image = Constants.iconImage.icons[weather.info.first!.icon]!
        cityName.text = city.name
        degreeLabel.text = "\(weather.temp.temp)°"
        someInfoLabel.text = Constants.weatherInfoWord.word[weather.info.first!.mainInfo] ?? ""
        minTempLabel.text = "\(weather.temp.tempMin)°"
        maxTempLabel.text = "\(weather.temp.tempMax)°"
        speedWindLabel.text = "\(weather.wind.speed)m/s"
    }
}
