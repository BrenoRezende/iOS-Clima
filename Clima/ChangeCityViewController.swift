//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Breno Rezende on 08/08/2019.
//  Copyright (c) 2019 brezende. All rights reserved.
//

import UIKit

protocol ChangeCityProtocol {
    func cityChanged(city: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate : ChangeCityProtocol?
    
    @IBOutlet weak var changeCityTextField: UITextField!

    @IBAction func getWeatherPressed(_ sender: AnyObject) {
    
        guard let cityName = changeCityTextField.text else { return }
        
        if !cityName.isEmpty {
            delegate?.cityChanged(city: cityName.trimmingCharacters(in: .whitespacesAndNewlines))
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
