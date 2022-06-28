//
//  WeatherVM.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 26.11.2021.
//

import Foundation
import MLBasicKit
import Combine

class WeatherVM: BaseVM {
    @Published var cityName: String = "Barcelona"
    @Published var weatherType: String? = nil
    @Published var currentCityTemp: String? = nil
    @Published var currentDate: String? = nil
    @Published var weather: WeatherResponse? = nil    
    var currentLocation: (latitude:Double, longitude:Double) = (41.3874, 2.1686)
}

extension WeatherVM {
    func fetchCurrentWeather() {
        // Get current weather
        WeatherApi().fetchWeather(latitude: currentLocation.latitude,
                                  longitude: currentLocation.longitude,
                                   succeed: { [weak self] (weather) in
            guard let self = self else { return }

            self.weather = weather
            self.currentDate = weather.currently?.time.map{ Utilities.sharedInstance.getFormatedDate(date: Double(($0))) }
            self.weatherType = weather.currently?.summary
            self.currentCityTemp = weather.currently?.temperature.map { Utilities.sharedInstance.convertFahrenheitToCelsius(fahrenheit:$0) }

        }, failed: { (error) in
            print(error)
        })
    }
}
