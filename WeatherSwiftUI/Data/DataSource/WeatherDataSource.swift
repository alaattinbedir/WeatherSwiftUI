//
//  WeatherDataSource.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 29.06.2022.
//

import Foundation
import MLNetworking

protocol WeatherDataSource {
    func fetchWeather(latitude: Double,
                      longitude: Double,
                      succeed: @escaping (WeatherResponse) -> Void,
                      failed: @escaping (ErrorMessage) -> Void)
}
