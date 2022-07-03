//
//  WeatherAPIEntity.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 30.06.2022.
//

import Foundation

struct WeatherModel: Codable {
    let weatherType: String
    let currentCityTemp: Double
    let currentDate: Int
    let responseDailyList: [ResponseData]
    let responseHourlyList: [ResponseData]
}
