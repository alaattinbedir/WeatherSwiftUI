//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import SwiftUI
import MLBaseSwiftUI
import MLNetworking

struct WeatherView: View {
    @StateObject public var vm = WeatherVM()

    var body: some View {
        ZStack {
            Image("AfterNoon")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            switch vm.loadingState {
            case .idle:
                Color.clear.onAppear()
            case .loading:
                ProgressView()
            case .failed(let error):
                AlertView(errorInfo: error)
            case .loaded(_):
                WeatherBodyView(vm: vm)
            }

        }.task {
            vm.fetchCurrentWeather()
        }.errorAlert(error: $vm.error) // ZStack
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct WeatherBodyView: View {
    let vm: WeatherVM
    var gridItemLayout = [GridItem(.flexible())]

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(vm.cityName)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(Font.custom("Arial Rounded MT Bold", size: 26))

            Text(vm.weatherType)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(Font.custom("Arial Rounded MT Bold", size: 17))
                .padding()

            Image("partlysunny")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)

            Text(vm.currentCityTemp)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(Font.custom("Arial Rounded MT Bold", size: 65))

            Text(vm.currentDate)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(Font.custom("Arial Rounded MT Bold", size: 20))

            ScrollView(.horizontal) {
                LazyHGrid(rows: gridItemLayout, spacing: 20) {
                    ForEach (vm.responseHourlyList, id: \.time ) { hourly in
                        WeatherHourlyCell(hourly: hourly)
                    }
                }
            }.padding(.leading, 30).padding(.trailing, 30).padding(.top, 30)

            List {
                ForEach (vm.responseDailyList, id: \.time ) { daily in
                    WeatherDailyCell(daily: daily).listRowSeparator(.hidden)
                }
            }.background(Color.clear.ignoresSafeArea())
                .onAppear {
                    vm.onAppear()
                }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
