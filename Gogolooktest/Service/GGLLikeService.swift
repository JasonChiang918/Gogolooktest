//
//  GGLLikeService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/8.
//

import Foundation

// 控制 GGLLike 資訊協定
protocol GGLLikeServiceProtocol {
    func addLike(mal_id: Int) -> Void
    func deleteLike(mal_id: Int) -> Void
    func isLike(mal_id: Int) -> Bool
}

class GGLLikeService: NSObject, GGLLikeServiceProtocol {
    
    static let sharedInstance = GGLLikeService()
    
    private static let STORE_KEY = "GGLLikes"
    private static let storeUrl = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL).appendingPathComponent(STORE_KEY)
    
    private var likes: [Int]!
    
    private override init() {
        super.init()
        
        do {
            let data = try Data(contentsOf: GGLLikeService.storeUrl)
            self.likes = try JSONDecoder().decode([Int].self, from: data)
        }
        catch {
            likes = [Int]()
            self.refreshStoreLikes()
        }
    }
    
    private func refreshStoreLikes() {
        do {
            let data = try JSONEncoder().encode(self.likes)
            try data.write(to: GGLLikeService.storeUrl)
        } catch {
            print("error:\(error)")
        }
    }
    
    func addLike(mal_id: Int) {
        if self.likes.contains(mal_id) {
            return
        }
        
        self.likes.append(mal_id)
        self.refreshStoreLikes()
    }
    
    func deleteLike(mal_id: Int) {
        guard let idx = self.likes.firstIndex(of: mal_id) else {
            return
        }
        
        self.likes.remove(at: idx)
        self.refreshStoreLikes()
    }
    
    func isLike(mal_id: Int) -> Bool {
        if self.likes.isEmpty {
            return false
        }
        
        return self.likes.contains(mal_id)
    }
    
}
