//
//  WeatherSwiftUIApp.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import SwiftUI

@main
struct WeatherSwiftUIApp: App {
    @UIApplicationDelegateAdaptor var delegate: WeatherAppDelegate
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
        }
    }
}
