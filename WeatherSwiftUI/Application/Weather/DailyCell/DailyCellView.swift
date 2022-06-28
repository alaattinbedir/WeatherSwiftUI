//
//  DailyCell.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import Foundation
import SwiftUI


struct WeatherDailyCell: View {
    let daily: ResponseData

    var body: some View {
        HStack {
            Text(Helper.sharedInstance.getDayFromDate(date: Double(daily.time ?? 0)))
                .foregroundColor(.white)
                .frame(width: 80, height: 25, alignment: .leading)
            Spacer()
            Image("partlysunny")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 25, alignment: .center)
            Spacer()
            Text(Helper.sharedInstance.convertFahrenheitToCelsius(fahrenheit:daily.apparentTemperatureHigh ?? 32))
                .foregroundColor(.white)
                .padding(7)
            Text(Helper.sharedInstance.convertFahrenheitToCelsius(fahrenheit:daily.temperatureHigh ?? 32))
                .foregroundColor(.gray)
                .padding(7)

        }.listRowBackground(Color.clear)
    }
}

