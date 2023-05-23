//
//  LocationView.swift
//  MapInSwiftUI
//
//  Created by Ennovation on 22.05.23.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    
    @EnvironmentObject private var vm : LocationViewModel
    let maxWidthForIpad : CGFloat = 700
    
    var body: some View {
        ZStack{
         
            mapLayer
            
            VStack(spacing: 1) {
                header
                .padding()
                .frame(maxWidth: maxWidthForIpad )
                Spacer()
              locationPrevieStack
            }
        }
        .sheet(item: $vm.sheetLocation) { location in
            
            LocationDetailView(location: location)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationView{
    
    private var header:some View{
        VStack {
            
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            }

           
            if vm.showLocationList{
                withAnimation(.easeInOut){
                    LocationListView()
                }
               
            }
            
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(radius: 20 , x: 0,y: 15)
    }
    
    private var mapLayer:some View{
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationPrevieStack:some View{
        ZStack{
            ForEach(vm.locations) { location in
                
                if vm.mapLocation == location{
                    LocationPreviewView(location: location)
                        .shadow(color:Color.black.opacity(0.3) ,radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                }
                
            }
        }
    }
    
}
