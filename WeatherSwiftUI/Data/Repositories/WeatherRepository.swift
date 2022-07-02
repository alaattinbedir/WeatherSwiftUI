//
//  WeatherDataSource.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 29.06.2022.
//

import Foundation
import MLNetworking

protocol WeatherRepositoryProtocol {
    func fetchWeather(latitude: Double,
                      longitude: Double,
                      succeed: @escaping (WeatherAPIEntity) -> Void,
                      failed: @escaping (ErrorMessage) -> Void)
}
