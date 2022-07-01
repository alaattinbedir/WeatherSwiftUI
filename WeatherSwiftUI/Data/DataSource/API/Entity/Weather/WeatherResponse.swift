/*
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation


struct WeatherResponse : Codable {
    let daily : Daily?
    let currently : Currently?
    let hourly : Hourly?
    let weather : WeatherAPIEntity

    enum CodingKeys: String, CodingKey {
        case daily = "daily"
        case currently = "currently"
        case hourly = "hourly"
    }

    enum CurrentlyKeys: String, CodingKey {
        case summary = "summary"
        case temperature = "temperature"
        case time = "time"
    }

    enum DailyKeys: String, CodingKey {
        case data = "data"
    }

    enum HourlyKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        daily = try values.decodeIfPresent(Daily.self, forKey: .daily)
        currently = try values.decodeIfPresent(Currently.self, forKey: .currently)
        hourly = try values.decodeIfPresent(Hourly.self, forKey: .hourly)

        let currentlyContainer = try values.nestedContainer(keyedBy: CurrentlyKeys.self, forKey: .currently)
        let temperature = try currentlyContainer.decode(Int.self, forKey: .temperature)
        let weatherType = try currentlyContainer.decode(String.self, forKey: .summary)
        let currentDate = try currentlyContainer.decode(Int.self, forKey: .time)

        let dailyContainer = try values.nestedContainer(keyedBy: DailyKeys.self, forKey: .daily)
        let responseDailyList = try dailyContainer.decode([ResponseData].self, forKey: .data)

        let hourlyContainer = try values.nestedContainer(keyedBy: HourlyKeys.self, forKey: .hourly)
        let responseHourlyList = try hourlyContainer.decode([ResponseData].self, forKey: .data)

        weather = WeatherAPIEntity (weatherType: weatherType,
                                    currentCityTemp: temperature,
                                    currentDate: currentDate,
                                    responseDailyList: responseDailyList,
                                    responseHourlyList: responseHourlyList)
    }
}

struct Currently : Codable {
    let temperature : Double?
    let time : Int?
    let summary : String?

    enum CodingKeys: String, CodingKey {
        case temperature = "temperature"
        case time = "time"
        case summary = "summary"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
        time = try values.decodeIfPresent(Int.self, forKey: .time)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
    }
}

struct Daily : Codable {
    let data : [ResponseData]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ResponseData].self, forKey: .data)
    }
}

struct Hourly : Codable {
    let data : [ResponseData]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ResponseData].self, forKey: .data)
    }
}

struct ResponseData : Codable {
    let temperature : Double?
    let temperatureHigh : Double?
    let time : Int?
    let apparentTemperature : Double?
    let apparentTemperatureHigh : Double?

    enum CodingKeys: String, CodingKey {
        case temperature = "temperature"
        case temperatureHigh = "temperatureHigh"
        case time = "time"
        case apparentTemperature = "apparentTemperature"
        case apparentTemperatureHigh = "apparentTemperatureHigh"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
        temperatureHigh = try values.decodeIfPresent(Double.self, forKey: .temperatureHigh)
        time = try values.decodeIfPresent(Int.self, forKey: .time)
        apparentTemperature = try values.decodeIfPresent(Double.self, forKey: .apparentTemperature)
        apparentTemperatureHigh = try values.decodeIfPresent(Double.self, forKey: .apparentTemperatureHigh)
    }
}

