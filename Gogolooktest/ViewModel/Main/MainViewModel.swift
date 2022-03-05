//
//  MainViewModel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/3.
//

import Foundation

// 主畫面 view model
final class MainViewModel: NSObject {
    
    var type: MainType! = .Anime
    
    private let gglBoService: GGLBoServiceProtocol
    
    init(gglBoService: GGLBoServiceProtocol = GGLBoService()) {
        self.gglBoService = gglBoService
    }
    
    func fetchTopInfos(page: Int? = 0, subtype: String? = "", completionHandler: @escaping (_ topInfos: [TopInfo]?) -> Void) {
        let mainType = type.rawValue.lowercased()
        
        self.gglBoService.fetchGGLBoAPI(type: mainType, page: page!+1, subtype: subtype!) { error, responseData in
            guard let _ = error, let _ = responseData else {
                completionHandler(responseData)
                
                return
            }
            
            completionHandler(nil)
        }
    }
    
}
