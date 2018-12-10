//
//  WeatherDetailViewController.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 07/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var heightTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var weatherDateLabel: UILabel!
    
    var isDisplay = true
    var rightDisplay = true
    var index: Int!
    var weatherList: [Weather]?
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstWeather = weatherList?.first {
            weatherDateLabel.text = DateHelper.dateCompleteFormater.string(from: firstWeather.date)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(upPreviewInfo))
        actionView.addGestureRecognizer(tap)
        actionView.isUserInteractionEnabled = true
        registerCell()
    }
    
    private func registerCell() {
        infoTableView.register(UINib(nibName: "WeatherDetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "infoCell")
        infoTableView.register(UINib(nibName: "WeatherHoursTableViewCell", bundle: nil), forCellReuseIdentifier: "hoursCell")
    }
    
    @objc func upPreviewInfo(recognizer: UIPanGestureRecognizer) {
        self.view.layoutIfNeeded()
        if isDisplay {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                let guide = self.view.safeAreaLayoutGuide
                self.heightTableViewConstraint.constant = guide.layoutFrame.size.height - self.bottomTableViewConstraint.constant - 80
                self.view.layoutIfNeeded()
                self.isDisplay = false
                self.infoTableView.isScrollEnabled = true
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                let guide = self.view.safeAreaLayoutGuide
                self.heightTableViewConstraint.constant = 160
                self.view.layoutIfNeeded()
                self.isDisplay = true
                self.infoTableView.isScrollEnabled = false
            }, completion: { _ in
                self.infoTableView.setContentOffset(.zero, animated: true)
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.infoTableView.isScrollEnabled = false
        self.view.layoutIfNeeded()
        self.heightTableViewConstraint.constant = 160
    }
    
    @IBAction func closeWeatherDetailViewAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! WeatherDetailInfoTableViewCell
            cell.configure(weather: weatherList![indexPath.row], city: city!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hoursCell", for: indexPath) as! WeatherHoursTableViewCell
            cell.configure(weather: weatherList![indexPath.row], rightDisplay: rightDisplay)
            rightDisplay = !rightDisplay
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        } else {
            return 50
        }
    }
    
}
