//
//  Json4Swift_Base.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Json4Swift_Base : Decodable {
    let kind : String?
    let etag : String?
    let nextPageToken : String?
    let regionCode : String?
    let pageInfo : PageInfo?
    let items : [Items]?

    enum CodingKeys: String, CodingKey {

        case kind = "kind"
        case etag = "etag"
        case nextPageToken = "nextPageToken"
        case regionCode = "regionCode"
        case pageInfo = "pageInfo"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        etag = try values.decodeIfPresent(String.self, forKey: .etag)
        nextPageToken = try values.decodeIfPresent(String.self, forKey: .nextPageToken)
        regionCode = try values.decodeIfPresent(String.self, forKey: .regionCode)
        pageInfo = try values.decodeIfPresent(PageInfo.self, forKey: .pageInfo)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }
}
