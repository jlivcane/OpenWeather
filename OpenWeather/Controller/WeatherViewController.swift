//
//  ViewController.swift
//  OpenWeather
//
//  Created by jekaterina.livcane on 18/09/2020.
//  Copyright © 2020 jekaterina.livcane. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    let weatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        styleUI()
    }
    
    func styleUI(){
        windSpeedLabel.layer.cornerRadius = 15
        windSpeedLabel.layer.borderWidth = 2
        
        humidityLabel.layer.cornerRadius = 15
        humidityLabel.layer.borderWidth = 2
        
    }
    
    
    //MARK: - Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("Longitude: \(location.coordinate.longitude) , latitude: \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params:  [String: String] = ["lat": latitude, "lon": longitude, "appid": weatherDataModel.apiId]
            getWeatherData(url: weatherDataModel.apiUrl, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Err:",error)
        cityLabel.text = "Weather Unavailable"
    }
    //MARK: Networking
    func getWeatherData(url: String, parameters: [String: String]) {
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.value != nil {
                print("Got weather data")
                let weatherJSON: JSON = JSON(response.value!)
                print("weatherJson: ", weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }else{
                print("error \(String(describing: response.error))")
                self.cityLabel.text = "Connection Issue"
            }
        }
        
    }
    
    //MARK: - JSON Parsing with SwiftyJSON
    func updateWeatherData(json: JSON) {
        
        if let tempResult = json["main"]["temp"].double{
            weatherDataModel.temp = Int(tempResult - 273.15)
            
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.humidity = json["main"]["humidity"].intValue
            weatherDataModel.windSpeed = json["wind"]["speed"].intValue
            
            
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData() 
        }else{
            self.cityLabel.text = "Connection Unavailable"
        }
        
    }
    
    //MARK: - Update UI
    func updateUIWithWeatherData(){
        
        cityLabel.text = weatherDataModel.city
        tempLabel.text = "\(weatherDataModel.temp) º"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        humidityLabel.text = "Humidity \n\(weatherDataModel.humidity) %"
        windSpeedLabel.text = "Wind Speed \n\(weatherDataModel.windSpeed) m/s"
        
    }
    
    //Mark: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as!
                ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    //MARK: - Change City Delegate
    func userEnteredNewCityName(city: String) {
        print(city)
        let params:  [String: String] = ["q": city, "appid": weatherDataModel.apiId]
        getWeatherData(url: weatherDataModel.apiUrl, parameters: params)
    }
}


