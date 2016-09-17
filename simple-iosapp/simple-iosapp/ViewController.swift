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
    
    @IBOutlet weak var Button:UIButton!
    @IBOutlet weak var city: UITextField!

    @IBOutlet weak var weatherStack: UIStackView!
    
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
            self.weatherStack.hidden = true
            self.errorLabel.hidden = false
        } else {
            let json = try? NSJSONSerialization.JSONObjectWithData(weatherData!, options: [])
            if let cities = json as? [[String: String]] {
                for (index, city) in cities.enumerate() {
                    labels[index]["name"]!.text = city["name"]
                    labels[index]["temp"]!.text = city["temp"]
                    labels[index]["desc"]!.text = city["desc"]
                    
                }
                self.errorLabel.hidden = true
                self.weatherStack.hidden = false
            } else {
                self.errorLabel.text = "Unable to deserialize weather :("
                self.weatherStack.hidden = true
                self.errorLabel.hidden = false
            }
        }
    }
    
    func fetchCustomWeather(city: String?) {
        var err: NSError?
        var weatherData: NSString?
        Weather.GoWeatherFetchCustomCity(city, &weatherData, &err)
        
        if err != nil {
            self.errorLabel.text = err?.localizedDescription
            self.weatherStack.hidden = true
            self.errorLabel.hidden = false
        } else {
            // TODO
        }
    }

}

