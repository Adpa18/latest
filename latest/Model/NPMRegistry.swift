//
//  NPMRegistry.swift
//  latest
//
//  Created by Adrien WERY on 7/10/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import Foundation

struct NPMRegistry: Codable {
    let distTags: [String: String]
    let time: [String: Date]
    let homepage: URL
    
    enum CodingKeys: String, CodingKey {
        case distTags = "dist-tags"
        case time
        case homepage
    }
}
