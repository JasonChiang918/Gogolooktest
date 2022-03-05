//
//  TopInfoFilterViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/6.
//

import Foundation

// TopInfo header view model
final class TopInfoFilterViewModel: NSObject {
    
    var subtypes: [String]!
    
    override private init() {
        super.init()
    }
    
    init(subtypes: [String]!) {
        super.init()
        
        self.subtypes = subtypes
    }
    
}
