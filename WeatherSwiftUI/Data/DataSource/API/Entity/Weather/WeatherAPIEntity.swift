//
//  WeatherAPIEntity.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 30.06.2022.
//

import Foundation

struct WeatherAPIEntity: Codable {
    let weatherType: String
    let currentCityTemp: Int
    let currentDate: Int
    let responseDailyList: [ResponseData]
    let responseHourlyList: [ResponseData]
}
