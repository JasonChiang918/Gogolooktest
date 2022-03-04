//
//  GGLBoService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import Foundation
import Moya
import Alamofire

// CompletionHandler
typealias GGLBoCompletionHandler = (_ error: Error?, _ responseData: [TopInfo]?) -> Void

// 取得 GGLBo 資訊協定
protocol GGLBoServiceProtocol {
    // server API
    func fetchGGLBoAPI(type: String, page: Int, subtype: String, completionHandler: @escaping GGLBoCompletionHandler) -> Void
}

class GGLBoService: GGLBoServiceProtocol {
    
    // API provider
    let provider = MoyaProvider<GGLService>(session: DefaultAlamofireSession.shared)
    
    // server API
    func fetchGGLBoAPI(type: String, page: Int, subtype: String, completionHandler: @escaping GGLBoCompletionHandler) -> Void {
        self.provider.request(.showGGLBos(type: type, page: page, subtype: subtype)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    var topInfos: [TopInfo]!
                    
                    let data: GGLBo! = try moyaResponse.map(GGLBo.self)
                    if !data.top.isEmpty {
                        topInfos = data.top
                        
                        // filter subtype
                        if !subtype.isEmpty {
                            topInfos = topInfos.filter { $0.type.lowercased() == subtype }
                        }
                        
                        if topInfos.isEmpty {
                            topInfos = nil
                        }
                    }
                    
                    let statusCode = moyaResponse.statusCode
                    print("statusCode:\(statusCode)")
                    
                    completionHandler(nil, topInfos)
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

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}
