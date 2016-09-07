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
    
    @IBOutlet weak var nantes: UIButton!
    @IBOutlet weak var Button:UIButton!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var temperatureLabel:UILabel!
    @IBOutlet weak var weatherLabel:UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fetchNantesWeather() {
        fetchWeatherByCity("Nantes, FR")
    }
    
    @IBAction func fetchPaloAltoWeather() {
        fetchWeatherByCity("Palo Alto")
    }
    
    @IBAction func fetchPragueWeather() {
        fetchWeatherByCity("Prague, CZ")
    }
    
    @IBAction func actionForButton() {
        city.resignFirstResponder()
        fetchWeatherByCity(self.city.text)
    }
    
    func fetchWeatherByCity(cityName: String?) {
        var err: NSError?
        var weather: GoWeatherCityWeather?
        Weather.GoWeatherFetchByName(cityName, &weather, &err)
        
        if err != nil {
            self.cityLabel.hidden = true
            self.temperatureLabel.hidden = true
            self.weatherLabel.hidden = true
            self.errorLabel.text = err?.localizedDescription
            self.errorLabel.hidden = false
        } else {
            self.errorLabel.hidden = true
            self.cityLabel.text = weather!.city()
            self.temperatureLabel.text = String(weather!.temperature())+"°C"
            self.weatherLabel.text = weather!.description()
            self.cityLabel.hidden = false
            self.temperatureLabel.hidden = false
            self.weatherLabel.hidden = false
        }
    }

}

