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
