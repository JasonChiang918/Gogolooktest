//
//  MainViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/3.
//

import Foundation

// 主畫面 view model
class MainViewModel: NSObject {
    
    enum MainType: String, CaseIterable {
        case Anime, Manga
    }
    
    enum AnimeSubtype: String, CaseIterable {
        case ALL, airing, upcoming, tv, movie, ova, special, bypopularity, favorite
    }
    
    enum MangaSubtype: String, CaseIterable {
        case ALL, manga, novels, oneshots, doujin, manhwa, manhua, bypopularity, favorite
    }
    
    var mainTypes: [String]! {
        MainType.allCases.map { $0.rawValue }
    }
    
    var animeSubtypes: [String]! {
        AnimeSubtype.allCases.map { $0.rawValue }
    }
    
    var mangaSubtypes: [String]! {
        MangaSubtype.allCases.map { $0.rawValue }
    }
    
}
