//
//  CityWeatherController.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 06/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces


class CityWeatherController: UIViewController {
    
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchCityWeatherBtn: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var tempLabel: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var backgroundImageWeather: UIImageView!
    @IBOutlet weak var adviceLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var city: City?
    var weathers: [(key: String, value: [Weather])]?
    var currentCoordinateLocation: CLLocationCoordinate2D?
    
    var currentCityWeather: City? {
        didSet {
            addInfoToUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    private func configUI() {
        self.view.backgroundColor = Constants.Colors.blueNight
    }
    
    //DISPLAY INFO CURRENT WEATHER
    private func addInfoToUI() {
        if let currentCityWeather = currentCityWeather {
            cityLabel.text = currentCityWeather.name
            tempLabel.setTitle("\(currentCityWeather.temp!.temp)°", for: .normal)
            weatherDescLabel.text = currentCityWeather.info!.first!.mainDescription
            weatherIcon.image = Constants.iconImage.icons[currentCityWeather.info!.first!.icon]!
            
            adviceLabel.text = Constants.weatherInfoWord.word[currentCityWeather.info!.first!.mainInfo] ?? ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailWeatherSegue" {
            if let wdvc = segue.destination as? WeatherDetailPageViewController {
                wdvc.weathers = weathers
                wdvc.city = city
            }
        }
    }
    
    //MARK: - CALL API OPENWEATHERMAP
    private func getWeatherCurrentLocation(coord: CLLocationCoordinate2D) {
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false
        self.refreshBtn.isHidden = true
        NetworkManager.shared.getWeatherCurrentLocation(latitude: coord.latitude, longtitude: coord.longitude) { (cityWeather, err) in
            if let err = err {
                UIUtils.presentOkAlert(controller: self, title: "Error", message: err.errorDescription!)
                self.refreshBtn.isHidden = false
            } else {
                if let cityWeather = cityWeather {
                    self.currentCityWeather = cityWeather
                }
            }
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        }
    }
    
   private func getFiveDayWeather(coordinate: CLLocationCoordinate2D) {
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false
        self.refreshBtn.isHidden = true
        NetworkManager.shared.getWeatherForFiveDays(latitude: coordinate.latitude, longtitude: coordinate.longitude) { (weatherList, err) in
            if let err = err {
                UIUtils.presentOkAlert(controller: self, title: "Error", message: err.errorDescription!)
                self.refreshBtn.isHidden = false
            } else {
                if let weatherList = weatherList {
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                    self.city = weatherList.city
                    
                    self.weathers = WeatherServices.shared.parseWeatherList(weatherList: weatherList)
                    self.performSegue(withIdentifier: "detailWeatherSegue", sender: nil)
                }
            }
        }
    }
    
   private func getCurrentDefaultWeather() {
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false
        self.refreshBtn.isHidden = true
        NetworkManager.shared.getCurrentWeather(cityName: "Paris") { (cityWeather, err) in
            if let err = err {
                UIUtils.presentOkAlert(controller: self, title: "Error", message: err.errorDescription!)
                self.refreshBtn.isHidden = false
            } else {
                if let cityWeather = cityWeather {
                    self.currentCityWeather = cityWeather
                }
            }
        }
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.isHidden = true
    }
    
    //MARK: - ACTION
    @IBAction func displaySearchCityAction(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func showCurrentWeatherCityDetailAction(_ sender: Any) {
        if let coord = currentCityWeather?.coord {
            self.getFiveDayWeather(coordinate: CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lon))
        }
    }
    
    @IBAction func refreshWeatherAction(_ sender: Any) {
        if let currentCoordinateLocation = currentCoordinateLocation {
            self.getWeatherCurrentLocation(coord: currentCoordinateLocation)
        } else {
            self.getCurrentDefaultWeather()
        }
    }
}

//MARK: - DELEGATE AUTOCOMPLETE GOOGLE
extension CityWeatherController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true) {
           self.getFiveDayWeather(coordinate: place.coordinate)
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - DELEGATE LOCATION
extension CityWeatherController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            self.getCurrentDefaultWeather()
            return
        }
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.currentCoordinateLocation = location.coordinate
        self.getWeatherCurrentLocation(coord: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
}
