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
        var weatherData: NSData?
        Weather.GoWeatherFetchDefaultCities(&weatherData, &err)
        
        if err != nil {
            self.weatherStack.hidden = true
            self.errorLabel.text = err?.localizedDescription
            self.errorLabel.hidden = false
        } else {
            self.errorLabel.hidden = true
            
            let json = try? NSJSONSerialization.JSONObjectWithData(weatherData!, options: [])
            if let cities = json as? [[String: AnyObject]] {
                for city in cities {
                    print(city["Name"]!)
                    if let name = city["Name"] as? String {
                        self.city1Name.text = name
                    }
                    //WIP
                }
            } else {
                print("pouet")
            }
            
            self.weatherStack.hidden = false
        }
    }

}

