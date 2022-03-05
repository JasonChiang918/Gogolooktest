//
//  TopInfoCollectionViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/6.
//

import Foundation

// TopInfo info view model
final class TopInfoCollectionViewModel: NSObject {
    
    var subtypes: [String]!
    
    override private init() {
        super.init()
    }
    
    init(subtypes: [String]!) {
        super.init()
        
        self.subtypes = subtypes
    }
    
    
}
