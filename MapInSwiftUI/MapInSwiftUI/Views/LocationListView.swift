//
//  LocationListView.swift
//  MapInSwiftUI
//
//  Created by Ennovation on 22.05.23.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var vm: LocationViewModel
    var body: some View {
        List{
            ForEach(vm.locations) { location in
                
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical , 4)
                .listRowBackground(Color.clear)
            }
        }
        .background(.thinMaterial)
        .listStyle(.plain)
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationListView {
    private func listRowView(location:Location) -> some View{
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 54 , height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
        }
    }
}
