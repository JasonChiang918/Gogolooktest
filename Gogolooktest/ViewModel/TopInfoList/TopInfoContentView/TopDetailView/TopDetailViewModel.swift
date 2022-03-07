//
//  TopDetailViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/5.
//

import Foundation

// TopDetail view model
final class TopDetailViewModel: NSObject {
    
    // 顯示資訊
    var detailTitle: String!
    var detailUrl: URL!
    
    override private init() {
        super.init()
    }
    
    init(detailTitle: String, detailUrl: URL) {
        super.init()
        
        self.detailTitle = detailTitle
        self.detailUrl = detailUrl
    }
    
}
