//
//  WeatherHoursTableViewCell.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 08/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit

class WeatherHoursTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rightHour: UILabel!
    @IBOutlet weak var rightInfo: UILabel!
    @IBOutlet weak var leftHour: UILabel!
    @IBOutlet weak var leftInfo: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        self.backgroundColor = .clear
    }
    
    func configure(weather:Weather, rightDisplay: Bool) {
        if rightDisplay {
            rightHour.isHidden = true
            rightInfo.isHidden = true
            leftHour.isHidden = false
            leftInfo.isHidden = false
            leftInfo.text = "\(weather.temp.temp)° \(weather.info.first!.mainDescription)"
            leftHour.text = DateHelper.dateTimeShortFormater.string(from: weather.date)
        } else {
            rightHour.isHidden = false
            rightInfo.isHidden = false
            leftHour.isHidden = true
            leftInfo.isHidden = true
            rightInfo.text = "\(weather.temp.temp)° \(weather.info.first!.mainDescription)"
            rightHour.text = DateHelper.dateTimeShortFormater.string(from: weather.date)
        }
        iconWeather.image = Constants.iconImage.icons[weather.info.first!.icon]!
    }
}
