//
//  MainViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/3.
//

import Foundation
import RxSwift

// 主畫面 view model
final class MainViewModel: NSObject {
    
    private let gglBoService = GGLBoService()
    
    var type: MainType! = .Anime
    
    public let topInfos : PublishSubject<[TopInfo]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<GGLServiceError> = PublishSubject()
    
    private let disposable = DisposeBag()
     
    public func fetchTopInfos() {
        self.loading.onNext(true)
        
        let mainType = type.rawValue.lowercased()
        
        self.gglBoService.fetchGGLBoAPI(type: mainType, page: 0, subtype: "") { error, responseData in
            self.loading.onNext(false)
            
            if let error = error {
                self.error.onNext(error)
            }
            else {
                self.topInfos.onNext(responseData ?? [])
            }
        }
    }
    
}
