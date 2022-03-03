//
//  GGLAnimeService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import Foundation
import Moya

// CompletionHandler
typealias AnimeCompletionHandler = (_ error: Error?, _ responseData: Anime?) -> Void

// 取得 Anime 資訊協定
protocol AnimeServiceProtocol {
    // server API
    func fetchAnimesAPI(page: Int?, subtype: String?, completionHandler: @escaping AnimeCompletionHandler) -> Void
}

class GGLAnimeService: AnimeServiceProtocol {
    
    // API provider
    let provider = MoyaProvider<GGLService>()
    
    // server API
    func fetchAnimesAPI(page: Int?=nil, subtype: String?=nil, completionHandler: @escaping AnimeCompletionHandler) -> Void {
        self.provider.request(.showAnimes(page: page, subtype: subtype)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.map(Anime.self)
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