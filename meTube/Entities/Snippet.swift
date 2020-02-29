//
//  Snippet.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Snippet : Decodable {
    let publishedAt : String?
    let channelId : String?
    let title : String?
    let description : String?
    let thumbnails : Thumbnails?
    let channelTitle : String?
    let liveBroadcastContent : String?

    enum CodingKeys: String, CodingKey {

        case publishedAt = "publishedAt"
        case channelId = "channelId"
        case title = "title"
        case description = "description"
        case thumbnails = "thumbnails"
        case channelTitle = "channelTitle"
        case liveBroadcastContent = "liveBroadcastContent"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        channelId = try values.decodeIfPresent(String.self, forKey: .channelId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        thumbnails = try values.decodeIfPresent(Thumbnails.self, forKey: .thumbnails)
        channelTitle = try values.decodeIfPresent(String.self, forKey: .channelTitle)
        liveBroadcastContent = try values.decodeIfPresent(String.self, forKey: .liveBroadcastContent)
    }
}
