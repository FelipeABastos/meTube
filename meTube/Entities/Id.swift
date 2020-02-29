//
//  Id.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Id : Decodable {
    let kind : String?
    let videoId : String?

    enum CodingKeys: String, CodingKey {

        case kind = "kind"
        case videoId = "videoId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        videoId = try values.decodeIfPresent(String.self, forKey: .videoId)
    }

}
