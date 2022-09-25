//
//  EditLocationView.swift
//  BucketList
//
//  Created by Jacek Kosinski U on 20/09/2022.
//

import SwiftUI

struct EditView: View {
    
    @StateObject private var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss

    var onSave: (Location) -> Void
    

    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Place name",text: $viewModel.name)
                    HStack{
                        Text("Latitude:\(viewModel.location.latitude)").font(.caption2)
                        Text("Longitude:\(viewModel.location.longitude)").font(.caption2)
                    }
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby..."){
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages,id: \.pageid) {page in
                            Text(page.title)
                                .font(.headline)
                            + Text (": " ) +
                            Text(page.description)
                                .italic()
                           
                        }
                    case .failed:
                        Text("Pleasy try again later.")
                    }
                }
            }
            
            .navigationTitle("Place details")
            .toolbar{
                Button("Save"){
                    let newLocation = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
                
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
        
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
      
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
    
 
}

struct EditLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) {_ in }
    }
}
