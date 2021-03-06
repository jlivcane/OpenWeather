//
//  WeatherDataModel.swift
//  OpenWeather
//
//  Created by jekaterina.livcane on 18/09/2020.
//  Copyright © 2020 jekaterina.livcane. All rights reserved.
//

import Foundation


class WeatherDataModel {
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather"
    let apiId = "b85bece6955ae05e6eda29751e4e5447"
    
    var temp: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    var humidity: Int = 0
    var windSpeed: Int = 0
    
    func updateWeatherIcon(condition: Int) -> String {
        switch (condition) {
        case 0...300 :
            return "tstorm1"
        case 301...500 :
            return "light_rain"
        case 501...600 :
            return "shower3"
        case 601...700 :
            return "snow4"
        case 701...771 :
            return "fog"
        case 772...799 :
            return "tstorm3"
        case 800 :
            return "sunny"
        case 801...804 :
            return "cloudy2"
        case 900...903, 905...1000  :
            return "tstorm3"
        case 903 :
            return "snow5"
        case 904 :
            return "sunny"
        default :
            return "dunno"
        }
    }
    
}
