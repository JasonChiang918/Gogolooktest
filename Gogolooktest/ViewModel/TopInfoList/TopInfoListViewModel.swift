//
//  TopInfoListViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import Foundation

// 主畫面 view model
final class TopInfoListViewModel: NSObject {
    
    // 顯示資訊
    var topInfos: [TopInfo]!
    var pageIdx = 0
    
    override private init() {
        super.init()
    }
    
    init(topInfos: [TopInfo]) {
        super.init()
        
        self.topInfos = topInfos
    }
    
}
