//
//  LocationViewModel.swift
//  MapInSwiftUI
//
//  Created by Ennovation on 22.05.23.
//

import Foundation
import MapKit
import SwiftUI
class LocationViewModel : ObservableObject{
    
    //Add Loaded Location
    @Published var locations: [Location]
    
    //Current Location on Map
    @Published var mapLocation : Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Current region on map
    @Published var mapRegion:MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    //show list of location
    @Published var showLocationList: Bool = false
    
    //show location detail via sheet
    @Published var sheetLocation:Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location:Location){
        
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
       
    }
    
     func toggleLocationList(){
        withAnimation(.easeInOut){
            showLocationList = !showLocationList
        }
    }
    
    func showNextLocation(location:Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed(){
        //get the current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            //("will never Happend")
            return
            
        }
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex)else{
            //next index is not valid
            //return 0
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        //next index is valid
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    
}
