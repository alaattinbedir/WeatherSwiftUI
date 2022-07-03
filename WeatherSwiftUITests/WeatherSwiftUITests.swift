//
//  WeatherSwiftUITests.swift
//  WeatherSwiftUITests
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import XCTest
import MLNetworking
@testable import WeatherSwiftUI


class MockWeatherApiService: WeatherApiServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double, succeed: @escaping (WeatherModel) -> Void, failed: @escaping (ErrorMessage) -> Void) {
        succeed(WeatherModel(weatherType: "Clear", currentCityTemp: 79.77, currentDate: 1656784865, responseDailyList: [], responseHourlyList: []))
    }
}

class WeatherSwiftUITests: XCTestCase {

    var sut: WeatherVM!

    override func setUpWithError() throws {
        sut = WeatherVM(apiService: MockWeatherApiService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    @MainActor func test_fetchWeather() throws {

        XCTAssert(sut.weatherType == "")

        sut.fetchCurrentWeather()

        XCTAssert(sut.weatherType == "Clear")
    }    
}
