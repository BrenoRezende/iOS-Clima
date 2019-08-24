//
//  ViewController.swift
//  WeatherApp
//
//  Created by Breno Rezende on 08/08/2019.
//  Copyright (c) 2019 brezende. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityProtocol {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithWeatherData(weatherDataModel: WeatherDataModel?) {
        
        if let weatherData = weatherDataModel {
            temperatureLabel.text = "\(weatherData.temperature) ºC"
            cityLabel.text = weatherData.city
            weatherIcon.image = UIImage(named: weatherData.weatherIcon)
        } else {
            temperatureLabel.text = ""
            cityLabel.text = "Weather Unavailable"
            weatherIcon.image = UIImage()
        }
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let weatherService = WeatherService()
            weatherService.getWeatherBy(latitude: latitude, longitude: longitude, completion: updateUIWithWeatherData)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
        cityLabel.text = "Unable to get your current location"
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    func cityChanged(city: String) {
        
        let weatherService = WeatherService()
        weatherService.getWeatherBy(cityName: city, completion: updateUIWithWeatherData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
}


