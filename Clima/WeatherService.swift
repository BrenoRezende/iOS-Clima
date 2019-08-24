//
//  WeatherService.swift
//  Clima
//
//  Created by Breno Rezende on 16/08/19.
//  Copyright © 2019 brezende. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherService {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "d4acbd23b3eeb7a7e17ed80a3f4ca355"
    
    func getWeatherBy(latitude: String, longitude: String, completion: @escaping (WeatherDataModel?) -> Void) {
        
        let params = ["lat": latitude, "lon": longitude, "appid": APP_ID]        
        getWeather(params, completion)
    }
    
    func getWeatherBy(cityName: String, completion: @escaping (WeatherDataModel?) -> Void) {
        
        let params = ["q": cityName, "appid": APP_ID]
        getWeather(params, completion)
    }
    
    fileprivate func getWeather(_ params: [String : String], _ completion: @escaping (WeatherDataModel?) -> Void) {
        
        let httpService = HttpService()
        httpService.require(url: WEATHER_URL, method: .get, params: params) {
            json in
            
            guard let json = json, let temp = json["main"]["temp"].double else {
                completion(nil)
                return
            }
            
            let weatherDataModel = WeatherDataModel(
                temperature: Int(temp - 273.15),
                city: json["name"].stringValue,
                condition: json["weather"][0]["id"].intValue,
                weatherIcon: self.updateWeatherIcon(condition: json["weather"][0]["id"].intValue))
            
            completion(weatherDataModel)
        }
    }
    
    fileprivate func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
    
}
