//
//  AlertView.swift
//  WeatherSwiftUI
//
//  Created by Alaattin Bedir on 1.07.2022.
//

import Foundation
import SwiftUI
import MLBaseSwiftUI

struct AlertView: View {
    @State public var showAlert = false
    @State public var errorInfo: ErrorInfo

    var body: some View {

        BaseView(isAlertPresented: $showAlert, errorInfo: $errorInfo) {
            Text("Test")
        }
//        .onReceive(vm.publisher) { (output) in
        .onAppear {     // used instead of above just for test

            self.showAlert = true
        }
    }
}
