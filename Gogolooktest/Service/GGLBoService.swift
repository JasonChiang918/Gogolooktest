//
//  GGLBoService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import Foundation
import Moya
import Alamofire


enum GGLServiceError {
    case InternetError(String)
    case RequestTimeoutError(String)
    case UnknownError(String)
    case Response404Error(String)
    
    var message: String {
        switch self {
        case .InternetError(let value), .RequestTimeoutError(let value), .UnknownError(let value), .Response404Error(let value):
            return value
        }
    }
}

// CompletionHandler
typealias GGLBoCompletionHandler = (_ error: GGLServiceError?, _ responseData: [TopInfo]?) -> Void

// 取得 GGLBo 資訊協定
protocol GGLBoServiceProtocol {
    // server API
    func fetchGGLBoAPI(type: String, page: Int, subtype: String, completionHandler: @escaping GGLBoCompletionHandler) -> Void
}

class GGLBoService: GGLBoServiceProtocol {
    
    // API provider
    let provider = MoyaProvider<GGLAPIService>(session: DefaultAlamofireSession.shared)
    
    // server API
    func fetchGGLBoAPI(type: String, page: Int, subtype: String, completionHandler: @escaping GGLBoCompletionHandler) -> Void {
        self.provider.request(.showGGLBos(type: type, page: page+1, subtype: subtype)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let statusCode = moyaResponse.statusCode
                    print("statusCode:\(statusCode)")
                    
                    if statusCode == 404 {
                        completionHandler(.Response404Error("No More Page."), nil)
                        
                        return
                    }
                    
                    var topInfos: [TopInfo]!
                    
                    let data: GGLBo! = try moyaResponse.map(GGLBo.self)
                    if !data.top.isEmpty {
                        topInfos = data.top
                    }
                    
                    completionHandler(nil, topInfos)
                }
                catch {
                    print("response error:\(error)")
                    completionHandler(.UnknownError(error.localizedDescription), nil)
                }
                
            case let .failure(error):
                let oriError = (error.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError)?.underlyingError as? NSError
                print("request error:\(oriError)")
                
                guard let oriError = oriError else {
                    completionHandler(.UnknownError(error.localizedDescription), nil)
                    return
                }
                
                var gglError: GGLServiceError!
                
                switch oriError.code {
                case -1009:
                    gglError = .InternetError("Check your Internet connection.")
                case -1001:
                    gglError = .RequestTimeoutError("Request Timeout.")
                default:
                    gglError = .UnknownError(error.localizedDescription)
                }
                
                completionHandler(gglError, nil)
            }
        }
    }
    
}

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}
