//
//  ContentView.swift
//  BucketList
//
//  Created by Jacek Kosinski U on 17/09/2022.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        if viewModel.isUnlocked {
            
        
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate){
                    VStack{
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44,height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
            .ignoresSafeArea()
            
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width:32,height: 32)

            VStack{
                Spacer()
                
                HStack{
                    VStack{
                        Text("Latitude:\(viewModel.mapRegion.center.latitude)")
                        
                            .font(.caption2)
                            .foregroundColor(.white)
                        Text("Longitude:\(viewModel.mapRegion.center.latitude)")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button{
                        //creaste new location
                        viewModel.addLocation()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }

                    
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditLocationView(location: place) {
                viewModel.update(location: $0)
            }
        }
        } else{
            Button("Odblokuj ten badziew" ) {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert("Nie rozpoznano użytkownika",isPresented: $viewModel.isShowingAuthenticationError){
                Button("OK"){}
                
            } message: {
                Text(viewModel.authenticationError)
            }
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
