//
//  ViewController.swift
//  simple-iosapp
//
//  Created by Antoine Richard on 22/08/16.
//  Copyright © 2016 Antoine Richard. All rights reserved.
//

import UIKit
import Weather

class ViewController: UIViewController {
    
    @IBOutlet weak var city: UITextField!
    @IBOutlet var Button:UIButton!
    @IBOutlet var temperatureLabel:UILabel!
    @IBOutlet var weatherLabel:UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionForButton() {
        var err: NSError?
        var weather: GoWeatherCityWeather?
        Weather.GoWeatherFetchByName(self.city.text, &weather, &err)
        
        if err != nil {
            self.errorLabel.text = err?.localizedDescription
            self.errorLabel.hidden = false
        } else {
            self.errorLabel.hidden = true
            self.cityLabel.text = weather!.city()
            self.temperatureLabel.text = String(weather!.temperature())+"°C"
            self.weatherLabel.text = weather!.description()
        }
        
    }

}

