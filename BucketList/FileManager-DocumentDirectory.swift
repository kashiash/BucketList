//
//  FileManager-DocumentDirectory.swift
//  BucketList
//
//  Created by Jacek Kosinski U on 25/09/2022.
//

import Foundation
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
