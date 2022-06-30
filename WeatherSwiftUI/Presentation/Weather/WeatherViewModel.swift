//
//  WeatherVM.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 26.11.2021.
//

import Foundation
import Combine
import UIKit
import MLBaseSwiftUI

@MainActor
class WeatherViewModel: BaseViewModel {
    @Published var cityName: String = "Barcelona"
    @Published var weatherType: String = ""
    @Published var currentCityTemp: String = ""
    @Published var currentDate: String = ""
    @Published var responseDailyList: [ResponseData] = []
    @Published var responseHourlyList: [ResponseData] = []

    var currentLocation: (latitude:Double, longitude:Double) = (41.3874, 2.1686)

    private let weatherApi: WeatherDataSource

    required convenience init() {
        self.init(weatherApi: WeatherAPI())
    }

    nonisolated init (weatherApi: WeatherDataSource = WeatherAPI()) {
        self.weatherApi = weatherApi
        super.init()
    }

    func onAppear() {
        // Set the default to clear
        UITableView.appearance().backgroundColor = .clear
    }
}

extension WeatherViewModel {
    func fetchCurrentWeather() {

        // Get current weather
        weatherApi.fetchWeather(latitude: currentLocation.latitude,
                                longitude: currentLocation.longitude,
                                succeed: { [weak self] (weather) in
            guard let self = self else { return }

            self.currentDate = Helper.sharedInstance.getFormatedDate(date: Double(weather.currentDate))
            self.weatherType = weather.weatherType
            self.currentCityTemp = Helper.sharedInstance.convertFahrenheitToCelsius(fahrenheit: weather.currentCityTemp)
            self.responseDailyList = weather.responseDailyList
            self.responseHourlyList = weather.responseHourlyList

        }, failed: { (error) in
            print(error)
        })
    }
}


