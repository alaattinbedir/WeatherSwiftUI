//
//  WeatherApiService.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 2.07.2022.
//

import Foundation
import MLNetworking

protocol WeatherApiServiceProtocol {
    func fetchWeather(latitude: Double,
                      longitude: Double,
                      succeed: @escaping (WeatherModel) -> Void,
                      failed: @escaping (ErrorMessage) -> Void)
}

final class WeatherApiService: WeatherApiServiceProtocol {

    private let apiKey = "b6dd3cedb673897c7f68486a9b40b7a3"
    // Get weather data from service
    func fetchWeather(latitude: Double,
                      longitude: Double,
                      succeed: @escaping (WeatherModel) -> Void,
                      failed: @escaping (ErrorMessage) -> Void) {

        BaseAPI.shared.request(methotType: .get,
                               baseURL: Keeper.shared.currentEnvironment.domainUrl,
                               endPoint: Endpoints.weather.replaceParamsWithCurlyBrackets(String(latitude), String(longitude), apiKey),
                               params: nil) { (response: WeatherResponse) in
            succeed(response.weather)
        } failed: { (errorMessage: ErrorMessage) in
            failed(errorMessage)
        }
    }
}
