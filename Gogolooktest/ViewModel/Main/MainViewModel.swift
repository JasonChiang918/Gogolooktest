//
//  MainViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/3.
//

import Foundation

// 主畫面 view model
final class MainViewModel: NSObject {
    
    var typeIdx = 0
    var subtypeIdx = 0
    
    private let gglBoService: GGLBoServiceProtocol
    
    init(gglBoService: GGLBoServiceProtocol = GGLBoService()) {
        self.gglBoService = gglBoService
    }
    
    func fetchTopInfos(page: Int? = 0, completionHandler: @escaping (_ topInfos: [TopInfo]?) -> Void) {
        let mainType = mainTypes[typeIdx].lowercased()
        let subType = subtypeIdx == 0 ? "" : subTypes[subtypeIdx].lowercased()
        
        self.gglBoService.fetchGGLBoAPI(type: mainType, page: page!+1, subtype: subType) { error, responseData in
            guard let _ = error, let _ = responseData else {
                completionHandler(responseData)
                
                return
            }
            
            completionHandler(nil)
        }
    }
    
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
    
    var subTypes: [String]! {
        if typeIdx == 0 {
            return animeSubtypes
        }
        else {
            return mangaSubtypes
        }
    }
    
    private var animeSubtypes: [String]! {
        AnimeSubtype.allCases.map { $0.rawValue }
    }
    
    private var mangaSubtypes: [String]! {
        MangaSubtype.allCases.map { $0.rawValue }
    }
    
}
