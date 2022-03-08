//
//  TopInfoContentViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/6.
//

import Foundation
import RxSwift
import Kingfisher

// TopInfo content view model
final class TopInfoContentViewModel: NSObject {
    
    var mainType: MainType!
    var topInfo: TopInfo!
    
    var mal_id: Int!
    var title: String!
    var type: String!
    var rank: String!
    var date: String!
    var imageResource: ImageResource!
    var isLike: Bool!
    
    public let updatingLike: PublishSubject<Bool> = PublishSubject()
    
    override private init() {
        super.init()
    }
    
    init(type: MainType, topInfo: TopInfo) {
        super.init()
        
        self.mainType = type
        self.topInfo = topInfo
        
        self.fullFillValues(topInfo: topInfo)
    }
    
    private func fullFillValues(topInfo: TopInfo) {
        self.mal_id = topInfo.mal_id
        self.title = topInfo.title + "\n"
        self.type = topInfo.type
        self.rank = "\(topInfo.rank)"
        
        self.date = ""
        if let startDate = topInfo.start_date {
            self.date += startDate
        }
        else {
            self.date += "?"
        }
        self.date += "~"
        if let endDate = topInfo.end_date {
            self.date += endDate
        }
        else {
            self.date += "now"
        }
        
        if let imageUrlString = topInfo.image_url, let imageUrl = URL(string: imageUrlString) {
            self.imageResource = ImageResource(downloadURL: imageUrl, cacheKey: imageUrlString)
        }
        
        self.isLike = GGLLikeService.sharedInstance.isLike(type: self.mainType, mal_id: self.mal_id)
    }
    
    public func updateLike() {
        self.updatingLike.onNext(true)
        
        if self.isLike {
            GGLLikeService.sharedInstance.deleteLike(type: self.mainType, mal_id: self.mal_id)
        }
        else {
            GGLLikeService.sharedInstance.addLike(type: self.mainType, topInfo: self.topInfo)
        }
        
        self.isLike = !isLike
        
        self.updatingLike.onNext(false)
    }
    
}
