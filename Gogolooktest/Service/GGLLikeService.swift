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

// 儲存資料單純，故使用UserDefaults
class GGLLikeService: NSObject, GGLLikeServiceProtocol {
    
    static let sharedInstance = GGLLikeService()
    
    private final let STORE_KEY = "GGLLikes"
    
    private var likes: [Int]!
    
    private override init() {
        print("init...")
        super.init()
        
        if let storeLikes = UserDefaults.standard.value(forKey: STORE_KEY) as? [Int] {
            likes = storeLikes
        }
        else {
            likes = [Int]()
            self.refreshStoreLikes()
        }
    }
    
    deinit {
        print("deinit...")
    }
    
    private func refreshStoreLikes() {
        UserDefaults.standard.set(likes, forKey: STORE_KEY)
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
