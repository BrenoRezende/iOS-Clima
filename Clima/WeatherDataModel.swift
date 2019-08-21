//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Breno Rezende on 08/08/2019.
//  Copyright (c) 2019 brezende. All rights reserved.
//

import UIKit

struct WeatherDataModel {
    
    var temperature: Int
    var city: String
    var condition: Int
    var weatherIcon: String
    
    init(temperature: Int, city: String, condition: Int, weatherIcon: String) {
        
        self.temperature = temperature
        self.city = city
        self.condition = condition
        self.weatherIcon = weatherIcon
    }

}
