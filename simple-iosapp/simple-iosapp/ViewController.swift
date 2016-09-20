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

    @IBOutlet weak var displayDefaultCitiesButton: UIButton!
    @IBOutlet weak var Button:UIButton!
    @IBOutlet weak var city: UITextField!

    @IBOutlet weak var weatherStack: UIStackView!
    @IBOutlet weak var city1: UIStackView!
    @IBOutlet weak var city3: UIStackView!
    
    @IBOutlet weak var city1Name: UILabel!
    @IBOutlet weak var city1Temp: UILabel!
    @IBOutlet weak var city1Desc: UILabel!
    
    @IBOutlet weak var city2Name: UILabel!
    @IBOutlet weak var city2Temp: UILabel!
    @IBOutlet weak var city2Desc: UILabel!
    
    @IBOutlet weak var city3Name: UILabel!
    @IBOutlet weak var city3Temp: UILabel!
    @IBOutlet weak var city3Desc: UILabel!
    
    var labels:[[String: UILabel]]=[[:]]
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var discardErrorButton: UIButton!
    @IBOutlet weak var errorStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labels = [[
                "name": city1Name,
                "temp": city1Temp,
                "desc": city1Desc
            ], [
                "name": city2Name,
                "temp": city2Temp,
                "desc": city2Desc
            ], [
                "name": city3Name,
                "temp": city3Temp,
                "desc": city3Desc
            ]
        ]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        fetchDefaultWeather()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionForButton() {
        city.resignFirstResponder()
        fetchCustomWeather(self.city.text)
    }
    
    func fetchDefaultWeather() {
        var err: NSError?
        var weatherData: NSData?
        Weather.GoWeatherFetchDefaultCities(&weatherData, &err)
        
        if err != nil {
            self.errorLabel.text = err?.localizedDescription
            self.errorStack.hidden = false
            self.weatherStack.hidden = true
        } else {
            let json = try? NSJSONSerialization.JSONObjectWithData(weatherData!, options: [])
            if let cities = json as? [[String: String]] {
                for (index, city) in cities.enumerate() {
                    labels[index]["name"]!.text = city["name"]
                    labels[index]["temp"]!.text = city["temp"]
                    labels[index]["desc"]!.text = city["desc"]
                }
                self.errorStack.hidden = true
                self.city1.hidden = false
                self.city3.hidden = false
                self.weatherStack.hidden = false
                self.displayDefaultCitiesButton.hidden = true
            } else {
                self.errorLabel.text = "Unable to deserialize weather :("
                self.errorStack.hidden = false
                self.weatherStack.hidden = true
            }
        }
    }
    
    func fetchCustomWeather(city: String?) {
        var err: NSError?
        var weatherData: NSData?
        Weather.GoWeatherFetchCustomCity(city, &weatherData, &err)
        
        if err != nil {
            self.errorLabel.text = err?.localizedDescription
            self.errorStack.hidden = false
            self.weatherStack.hidden = true
        } else {
            let json = try? NSJSONSerialization.JSONObjectWithData(weatherData!, options: [])
            if let city = json as? [String: String] {
                labels[1]["name"]!.text = city["name"]
                labels[1]["temp"]!.text = city["temp"]
                labels[1]["desc"]!.text = city["desc"]
                self.errorStack.hidden = true
                self.city1.hidden = true
                self.city3.hidden = true
                self.weatherStack.hidden = false
                self.displayDefaultCitiesButton.hidden = false
            } else {
                self.errorLabel.text = "Unable to deserialize weather :("
                self.errorStack.hidden = false
                self.weatherStack.hidden = true
            }
        }
    }
    @IBAction func displayDefaultCities() {
        fetchDefaultWeather()
    }
    
    @IBAction func discardError() {
        self.errorStack.hidden = true
        fetchDefaultWeather()
    }

}

