//
//  TopInfoListViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import Foundation

// TopInfo list view model
final class TopInfoListViewModel: NSObject {
    
    weak var mainViewModel: MainViewModel?
    
    // 顯示資訊
    var topInfos: [TopInfo]!
    var pageIdx = 0
    
    override private init() {
        super.init()
    }
    
    init(topInfos: [TopInfo], mainViewModel: MainViewModel?) {
        super.init()
        
        self.topInfos = topInfos
        self.mainViewModel = mainViewModel
    }
    
    func getTopInfos(completionHandler: @escaping (_ hasNewData: Bool) -> Void) {
        self.mainViewModel?.fetchTopInfos(page: self.pageIdx+1, completionHandler: { newTopInfos in
            if let newTopInfos = newTopInfos {
                self.pageIdx += 1
                
                self.topInfos += newTopInfos
                
                completionHandler(true)
            }
            else {
                // end no data
                completionHandler(false)
            }
        })
                 
    }
    
}
