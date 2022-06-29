//
//  WeatherVM.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 26.11.2021.
//

import Foundation
import MLBasicKit
import Combine
import UIKit

@MainActor
class WeatherVM: BaseVM {
    @Published var cityName: String = "Barcelona"
    @Published var weatherType: String? = nil
    @Published var currentCityTemp: String? = nil
    @Published var currentDate: String? = nil
    @Published var responseDailyList: [ResponseData]? = [ResponseData]()
    @Published var responseHourlyList: [ResponseData]? = [ResponseData]()

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

extension WeatherVM {
    func fetchCurrentWeather() {

        // Get current weather
        weatherApi.fetchWeather(latitude: currentLocation.latitude,
                                  longitude: currentLocation.longitude,
                                   succeed: { [weak self] (weather) in
            guard let self = self else { return }

            self.currentDate = weather.currently?.time.map{ Helper.sharedInstance.getFormatedDate(date: Double(($0))) }
            self.weatherType = weather.currently?.summary
            self.currentCityTemp = weather.currently?.temperature.map { Helper.sharedInstance.convertFahrenheitToCelsius(fahrenheit:$0) }
            self.responseDailyList = weather.daily?.data
            self.responseHourlyList = weather.hourly?.data

        }, failed: { (error) in
            print(error)
        })
    }
}


