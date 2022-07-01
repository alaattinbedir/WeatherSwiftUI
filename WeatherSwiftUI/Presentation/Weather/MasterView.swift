//
//  MasterView.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 1.07.2022.
//

import SwiftUI
import MLBaseSwiftUI

struct MasterView: View {
    @State private var showModal = false

    var body: some View {
        VStack {
            Button("Show modal") {
                self.showModal = true
            }
        }.sheet(isPresented: $showModal, onDismiss: {
            print(self.showModal)
        }) {
            ModalView(message: "This is Modal view")
        }
    }
}
