//
//  PageInfo.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct PageInfo : Decodable {
    let totalResults : Int?
    let resultsPerPage : Int?

    enum CodingKeys: String, CodingKey {

        case totalResults = "totalResults"
        case resultsPerPage = "resultsPerPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        resultsPerPage = try values.decodeIfPresent(Int.self, forKey: .resultsPerPage)
    }
}
