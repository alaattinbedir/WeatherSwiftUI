//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var weatherVM = WeatherVM()
    private var gridItemLayout = [GridItem(.flexible())]

    var body: some View {
        ZStack {
            Image("AfterNoon")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 0) {
                Text(weatherVM.cityName)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 26))

                Text(weatherVM.weatherType ?? "Clear")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 17))
                    .padding()

                Image("partlysunny")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)

                Text(weatherVM.currentCityTemp ?? "23")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 65))

                Text(weatherVM.currentDate ?? "Haz 27, 2022")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))

                ScrollView(.horizontal) {
                    LazyHGrid(rows: gridItemLayout, spacing: 20) {
                        ForEach (weatherVM.responseHourlyList!, id: \.time ) { hourly in
                            WeatherHourlyCell(hourly: hourly)
                        }
                    }
                }.padding(.leading, 30).padding(.trailing, 30).padding(.top, 30)

                List {
                    ForEach (weatherVM.responseDailyList!, id: \.time ) { daily in
                        WeatherDailyCell(daily: daily).listRowSeparator(.hidden)
                    }
                }.background(Color.clear.ignoresSafeArea())
                    .onAppear {
                        // Set the default to clear
                        UITableView.appearance().backgroundColor = .clear
                    }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // VSTACK
        }.task {
            weatherVM.fetchCurrentWeather()
        }
        // ZStack
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct WeatherDailyCell: View {

    let daily: ResponseData
    
    var body: some View {
        HStack {
            Text(Utilities.sharedInstance.getDayFromDate(date: Double(daily.time ?? 0)))
                .foregroundColor(.white)
                .frame(width: 80, height: 25, alignment: .leading)
            Spacer()
            Image("partlysunny")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 25, alignment: .center)
            Spacer()
            Text(Utilities.sharedInstance.convertFahrenheitToCelsius(fahrenheit:daily.apparentTemperatureHigh ?? 32))
                .foregroundColor(.white)
                .padding(7)
            Text(Utilities.sharedInstance.convertFahrenheitToCelsius(fahrenheit:daily.temperatureHigh ?? 32))
                .foregroundColor(.gray)
                .padding(7)

        }.listRowBackground(Color.clear)
    }
}

struct WeatherHourlyCell: View {
    let hourly: ResponseData

    var body: some View {
        VStack {
            Text(Utilities.sharedInstance.getHourFromDate(date: Double(hourly.time ?? 0)))
                .foregroundColor(.white)
            Image("partlysunny")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 30, alignment: .center)
            Text(Utilities.sharedInstance.convertFahrenheitToCelsius(fahrenheit: hourly.temperature ?? 0))
                .foregroundColor(.white)
        }
    }
}
