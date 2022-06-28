//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 28.06.2022.
//

import SwiftUI

struct WeatherView: View {

    var body: some View {
        ZStack {
            Image("AfterNoon")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 0) {
                Text("Barcelona")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 26))

                Text("Clear")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 17))
                    .padding()

                Image("partlysunny")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)

                Text("23")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 65))


                Text("Haz 28, 2022")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))


            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // VSTACK
        }
        // ZStack
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
