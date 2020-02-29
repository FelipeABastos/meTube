//
//  Thumbnails.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Thumbnails : Decodable {
    let medium : Medium?
    let high : High?

    enum CodingKeys: String, CodingKey {

        case medium = "medium"
        case high = "high"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        medium = try values.decodeIfPresent(Medium.self, forKey: .medium)
        high = try values.decodeIfPresent(High.self, forKey: .high)
    }
}
