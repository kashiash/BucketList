//
//  Location.swift
//  BucketList
//
//  Created by Jacek Kosinski U on 20/09/2022.
//

import Foundation
struct Location: Identifiable,Codable,Equatable{
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
