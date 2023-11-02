//
//  HourlyCellView.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import Foundation
import SwiftUI

struct WeatherHourlyCell: View {
    let hourly: Current

    var body: some View {
        VStack {
            Text(Helper.sharedInstance.getHourFromDate(date: Double(hourly.dt)))
                .foregroundColor(.white)
            Image("partlysunny")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 26, alignment: .center)
            Text(Helper.sharedInstance.convertFahrenheitToCelsius(fahrenheit: hourly.temp))
                .foregroundColor(.white)
        }
    }
}

