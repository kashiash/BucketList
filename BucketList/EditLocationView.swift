//
//  EditLocationView.swift
//  BucketList
//
//  Created by Jacek Kosinski U on 20/09/2022.
//

import SwiftUI

struct EditLocationView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Place name",text: $name)
                    TextField("Description", text: $description)
                }
            }
            
            .navigationTitle("Place details")
            .toolbar{
                Button("Save"){
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
        
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location  = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EditLocationView(location: Location.example) {_ in }
    }
}
