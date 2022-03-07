//
//  TopInfoListViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import Foundation
import RxSwift
import UIKit

// TopInfo list view model
final class TopInfoListViewModel: NSObject {
    
    private let gglBoService = GGLBoService()
    
    // 顯示資訊
    var type: MainType!
    var subtypeString = AnimeSubtype.All.rawValue.lowercased()
    var subTypes: [String]! {
        return self.type == .Anime ? AnimeSubtype.typeStrings : MangaSubtype.typeStrings
    }
    // Dic: [subtype : TopInfoDic]
    var filteredTopInfos: [String : TopInfoDic]!
    
    public class TopInfoDic {
        var pageIdx: Int!
        var topInfos: [TopInfo]!
        var noMoreData = false
        var point: CGPoint! = .zero
        
        init(pageIdx: Int, topInfos: [TopInfo]) {
            self.pageIdx = pageIdx
            self.topInfos = topInfos
        }
    }
    
    // fetch new data
    public let hasNextPage : PublishSubject<Bool> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<GGLServiceError> = PublishSubject()
    // select subtype
    public let selectSubtype : PublishSubject<String> = PublishSubject()
    
    override private init() {
        super.init()
    }
    
    init(type: MainType, topInfos: [TopInfo]) {
        super.init()
        
        self.type = type
        self.filterTopInfos(topInfos: topInfos)
    }
    
    private func filterTopInfos(topInfos: [TopInfo]) {
        self.filteredTopInfos = [String : TopInfoDic]()
        
        for i in 0..<subTypes.count {
            let subType = subTypes[i].lowercased()
            self.filteredTopInfos[subType] = i == 0 ? .init(pageIdx: 1, topInfos: topInfos) : .init(pageIdx: 0, topInfos: [TopInfo]())
        }
    }
    
    func getCurrentTopInfoDic() -> TopInfoDic {
        return filteredTopInfos[subtypeString]!
    }
    
    private func addNewTopInfoToCurrentTopInfoDic(topInfos: [TopInfo]) {
        let currentTopInfoDic = getCurrentTopInfoDic()
        currentTopInfoDic.pageIdx += 1
        currentTopInfoDic.topInfos += topInfos
    }
    
    public func fetchNextTopInfos() {
        self.loading.onNext(true)
        
        let mainType = type.rawValue.lowercased()
        let pageIdx = getCurrentTopInfoDic().pageIdx!
        let subType = subtypeString == AnimeSubtype.All.rawValue.lowercased() ? "" : subtypeString
        
        self.gglBoService.fetchGGLBoAPI(type: mainType, page: pageIdx, subtype: subType) { [weak self] error, responseData in
            self?.loading.onNext(false)
            
            if let error = error {
                print("error:\(error)")
                self?.error.onNext(error)
            }
            else {
                if let newTopInfos = responseData, !newTopInfos.isEmpty {
                    self?.addNewTopInfoToCurrentTopInfoDic(topInfos: newTopInfos)
                    
                    self?.hasNextPage.onNext(true)
                }
                else {
                    self?.hasNextPage.onNext(false)
                }
            }
        }
    }
    
    
}
