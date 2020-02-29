//
//  Items.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Items : Decodable {
    let kind : String?
    let id : Id?
    let snippet : Snippet?

    enum CodingKeys: String, CodingKey {

        case kind = "kind"
        case id = "id"
        case snippet = "snippet"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        id = try values.decodeIfPresent(Id.self, forKey: .id)
        snippet = try values.decodeIfPresent(Snippet.self, forKey: .snippet)
    }
}
