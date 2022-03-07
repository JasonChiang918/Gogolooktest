//
//  TopInfoFilterViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/6.
//

import Foundation
import RxSwift
import RxCocoa

// TopInfo header view model
final class TopInfoFilterViewModel: NSObject {
    
    var subtypes: [String]!
    var subtypeIdx = 0

    // select subtype
    public let selectSubtype : PublishSubject<String> = PublishSubject()
    
    override private init() {
        super.init()
    }
    
    init(subtypes: [String]!) {
        super.init()
        
        self.subtypes = subtypes
    }
    
    func selectSubtype(idx: Int) {
        self.subtypeIdx = idx
        selectSubtype.onNext(subtypes[idx])
    }
    
}
