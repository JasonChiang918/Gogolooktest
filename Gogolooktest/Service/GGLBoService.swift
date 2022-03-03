//
//  GGLBoService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import Foundation
import Moya

// CompletionHandler
typealias GGLBoCompletionHandler = (_ error: Error?, _ responseData: GGLBo?) -> Void

// 取得 GGLBo 資訊協定
protocol GGLBoServiceProtocol {
    // server API
    func fetchGGLBoAPI(type: String, page: Int, subtype: String, completionHandler: @escaping GGLBoCompletionHandler) -> Void
}

class GGLBoService: GGLBoServiceProtocol {
    
    // API provider
    let provider = MoyaProvider<GGLService>()
    
    // server API
    func fetchGGLBoAPI(type: String, page: Int, subtype: String, completionHandler: @escaping GGLBoCompletionHandler) -> Void {
        self.provider.request(.showGGLBos(type: type, page: page, subtype: subtype)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    var data: GGLBo! = try moyaResponse.map(GGLBo.self)
                    // filter subtype
                    if !subtype.isEmpty {
                        data.top = data.top.filter { $0.type.lowercased() == subtype }
                    }
                    
                    if data.top.isEmpty {
                        data = nil
                    }
                    
                    let statusCode = moyaResponse.statusCode
                    print("statusCode:\(statusCode) data:\(data)")
                    completionHandler(nil, data)
                }
                catch {
                    print("error:\(error)")
                    completionHandler(error, nil)
                }
                
            case let .failure(error):
                print("error:\(error)")
                completionHandler(error, nil)
            }
        }
    }
    
}
