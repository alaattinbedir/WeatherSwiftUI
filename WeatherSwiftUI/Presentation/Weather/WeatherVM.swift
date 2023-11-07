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
import MLNetworking

@MainActor
class WeatherVM: BaseVM {
    @Published var cityName: String = "Barcelona"
    @Published var weatherType: String = ""
    @Published var currentCityTemp: String = ""
    @Published var currentDate: String = ""
    @Published var responseDailyList: [Daily] = []
    @Published var responseHourlyList: [Current] = []

    var currentLocation: (latitude:Double, longitude:Double) = (41.3874, 2.1686)

    private let apiService: WeatherApiServiceProtocol

    required convenience init() {
        self.init(apiService: WeatherApiService())
    }

    nonisolated init (apiService: WeatherApiServiceProtocol = WeatherApiService()) {
        self.apiService = apiService
        super.init()
    }

    func onAppear() {
        // Set the default to clear
        UITableView.appearance().backgroundColor = .clear
    }
}

extension WeatherVM {
    func fetchCurrentWeather() {

        self.loadingState = .loading
        // Get current weather
        apiService.fetchWeather(latitude: currentLocation.latitude,
                                longitude: currentLocation.longitude,
                                succeed: { [weak self] (weather) in
            guard let self = self else { return }

            self.currentDate = Helper.sharedInstance.getFormatedDate(date: Double(weather.currentDate))
            self.weatherType = weather.weatherType
            self.currentCityTemp = Helper.sharedInstance.convertFahrenheitToCelsius(fahrenheit: Double(weather.currentCityTemp))
            self.responseDailyList = weather.responseDailyList
            self.responseHourlyList = weather.responseHourlyList

            self.loadingState = .loaded(weather)
        }, failed: { (error) in
            self.loadingState = .failed(ErrorInfo(id: error.code* , title: "Warning", message: error.message*))
        })
    }
}
