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
    
    @IBOutlet var Button:UIButton!
    @IBOutlet var temperatureLabel:UILabel!
    @IBOutlet var weatherLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionForButton() {
        let weather = Weather.GoWeatherFetch()
        self.temperatureLabel.text = String(weather.temperature())+"°C"
        self.weatherLabel.text = weather.text()
    }

}

