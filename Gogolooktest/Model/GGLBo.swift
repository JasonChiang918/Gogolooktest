//
//  GGLBo.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import Foundation

// tops
struct GGLBo: Decodable {
    let request_hash: String
    let request_cached: Bool
    let request_cache_expiry: Int
    let API_DEPRECATION: Bool
    let API_DEPRECATION_DATE: String
    let API_DEPRECATION_INFO: String
    var top: [TopInfo]!
}

// top 資訊
struct TopInfo: Decodable {
    let mal_id: Int
    let rank: Int
    let title: String
    let url: String
    let image_url: String
    let type: String
    let start_date: String
    let end_date: String?
    let members: Int
    let score: Float
}
