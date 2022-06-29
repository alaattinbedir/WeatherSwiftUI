//
//  HourlyCellView.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import Foundation
import SwiftUI

struct WeatherHourlyCell: View {
    let hourly: ResponseData

    var body: some View {
        VStack {
            Text(Helper.sharedInstance.getHourFromDate(date: Double(hourly.time ?? 0)))
                .foregroundColor(.white)
            Image("partlysunny")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 30, alignment: .center)
            Text(Helper.sharedInstance.convertFahrenheitToCelsius(fahrenheit: hourly.temperature ?? 0))
                .foregroundColor(.white)
        }
    }
}

