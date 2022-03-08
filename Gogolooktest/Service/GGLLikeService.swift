//
//  GGLLikeService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/8.
//

import Foundation

// 控制 GGLLike 資訊協定
protocol GGLLikeServiceProtocol {
    func addLike(type: MainType, topInfo: TopInfo) -> Void
    func deleteLike(type: MainType, mal_id: Int) -> Void
    func isLike(type: MainType, mal_id: Int) -> Bool
}

class GGLLikeService: NSObject, GGLLikeServiceProtocol {
    
    static let sharedInstance = GGLLikeService()
    
    private static let ANIME_STORE_KEY = "GGLAnimeLikes"
    private static let MANGA_STORE_KEY = "GGLMangaLikes"
    private static let animeStoreUrl = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL).appendingPathComponent(ANIME_STORE_KEY)
    private static let mangaStoreUrl = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL).appendingPathComponent(MANGA_STORE_KEY)
    
    private var animeLikes: [Int : TopInfo]!
    private var mangaLikes: [Int : TopInfo]!
    
    private override init() {
        super.init()
        
        // read anime
        do {
            let animeData = try Data(contentsOf: GGLLikeService.animeStoreUrl)
            self.animeLikes = try JSONDecoder().decode([Int : TopInfo].self, from: animeData)
        }
        catch {
            self.animeLikes = [Int : TopInfo]()
            self.refreshStoreLikes(type: .Anime)
        }
        
        // read manga
        do {
            let mangaData = try Data(contentsOf: GGLLikeService.mangaStoreUrl)
            self.mangaLikes = try JSONDecoder().decode([Int : TopInfo].self, from: mangaData)
        }
        catch {
            self.mangaLikes = [Int : TopInfo]()
            self.refreshStoreLikes(type: .Manga)
        }
    }
    
    private func refreshStoreLikes(type: MainType) {
        switch type {
        case .Anime:
            do {
                let animeData = try JSONEncoder().encode(self.animeLikes)
                try animeData.write(to: GGLLikeService.animeStoreUrl)
            } catch {
                print("error:\(error)")
            }
        case .Manga:
            do {
                let mangaData = try JSONEncoder().encode(self.mangaLikes)
                try mangaData.write(to: GGLLikeService.mangaStoreUrl)
            } catch {
                print("error:\(error)")
            }
        }
        
    }
    
    func addLike(type: MainType, topInfo: TopInfo) {
        let mal_id = topInfo.mal_id
        
        switch type {
        case .Anime:
            if self.animeLikes.keys.contains(mal_id) {
                return
            }
            self.animeLikes[mal_id] = topInfo
            
        case .Manga:
            if self.mangaLikes.keys.contains(mal_id) {
                return
            }
            self.mangaLikes[mal_id] = topInfo
        }
        
        
        self.refreshStoreLikes(type: type)
    }
    
    func deleteLike(type: MainType, mal_id: Int) {
        switch type {
        case .Anime:
            guard let idx = self.animeLikes.keys.firstIndex(of: mal_id) else {
                return
            }
            self.animeLikes.remove(at: idx)
            
        case .Manga:
            guard let idx = self.mangaLikes.keys.firstIndex(of: mal_id) else {
                return
            }
            self.mangaLikes.remove(at: idx)
        }
        
        self.refreshStoreLikes(type: type)
    }
    
    func isLike(type: MainType, mal_id: Int) -> Bool {
        switch type {
        case .Anime:
            if self.animeLikes.isEmpty {
                return false
            }
            return self.animeLikes.keys.contains(mal_id)
            
        case .Manga:
            if self.mangaLikes.isEmpty {
                return false
            }
            return self.mangaLikes.keys.contains(mal_id)
            
        }
    }
    
    func genTopInfosToDic(type: MainType) -> TopInfoDic {
        var topInfos: [TopInfo]!
        
        switch type {
        case .Anime:
            topInfos = Array(self.animeLikes.values)
            
        case .Manga:
            topInfos = Array(self.mangaLikes.values)
        }
        
        return TopInfoDic(pageIdx: 0, topInfos: topInfos, noMoreData: true)
    }
    
}
