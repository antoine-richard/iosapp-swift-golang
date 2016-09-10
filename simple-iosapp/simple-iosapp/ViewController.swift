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
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
//            #selector(ViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        fetchWeatherByCity()
    }
    
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionForButton() {
//        city.resignFirstResponder()
//        fetchWeatherByCity(self.city.text)
    }
    
    func fetchWeatherByCity() {
        var err: NSError?
        var weather: GoWeatherCityWeather?
        Weather.GoWeatherFetch(&weather, &err)
        
        if err != nil {
            self.weatherStack.hidden = true
            self.errorLabel.text = err?.localizedDescription
            self.errorLabel.hidden = false
        } else {
            self.errorLabel.hidden = true
            
            self.city1Name.text = weather!.city1Name()
            self.city1Temp.text = weather!.city1Temp()
            self.city1Desc.text = weather!.city1Desc()
            
            self.city2Name.text = weather!.city2Name()
            self.city2Temp.text = weather!.city2Temp()
            self.city2Desc.text = weather!.city2Desc()
            
            self.city3Name.text = weather!.city3Name()
            self.city3Temp.text = weather!.city3Temp()
            self.city3Desc.text = weather!.city3Desc()
            
            self.weatherStack.hidden = false
        }
    }

}

