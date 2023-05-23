//
//  MapInSwiftUIApp.swift
//  MapInSwiftUI
//
//  Created by Ennovation on 22.05.23.
//

import SwiftUI

@main
struct MapInSwiftUIApp: App {
    @StateObject private var vm = LocationViewModel()
    var body: some Scene {
        WindowGroup {
           LocationView()
                .environmentObject(vm)
        }
    }
}
