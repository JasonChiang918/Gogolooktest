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
struct TopInfo: Decodable, Encodable {
    let mal_id: Int
    let rank: Int
    let title: String
    let url: String?
    let image_url: String?
    let type: String
    let start_date: String?
    let end_date: String?
    let members: Int?
    let score: Float?
}

// main type 資訊
enum MainType: String, CaseIterable {
    case Anime, Manga
    
    init(idx: Int) {
        self = (.init(rawValue: MainType.typeStrings[idx]) ?? .Anime)
    }
    
    static var typeStrings: [String]! {
        MainType.allCases.map { $0.rawValue }
    }
}

// anime type 資訊
enum AnimeSubtype: String, CaseIterable {
    case AllTypes, airing, upcoming, tv, movie, ova, special, bypopularity, favorite
    
    static var typeStrings: [String]! {
        AnimeSubtype.allCases.map { $0.rawValue }
    }
    
    static var All: AnimeSubtype {
        return AnimeSubtype.allCases[0]
    }
    
    static func IsAll(type: String) -> Bool {
        return type.lowercased() == All.rawValue.lowercased()
    }
    
}

// manga type 資訊
enum MangaSubtype: String, CaseIterable {
    case AllTypes, manga, novels, oneshots, doujin, manhwa, manhua, bypopularity, favorite
    
    static var typeStrings: [String]! {
        MangaSubtype.allCases.map { $0.rawValue }
    }
    
}

// source type 資訊
enum SourceType: String, CaseIterable {
    case ServerData, MyFavorite
    
    static var typeStrings: [String]! {
        SourceType.allCases.map { $0.rawValue }
    }
}
