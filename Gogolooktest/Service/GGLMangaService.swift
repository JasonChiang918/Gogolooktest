//
//  GGLMangaService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import Foundation
import Moya

// CompletionHandler
typealias MangaCompletionHandler = (_ error: Error?, _ responseData: Manga?) -> Void

// 取得 Manga 資訊協定
protocol MangaServiceProtocol {
    // server API
    func fetchMangasAPI(completionHandler: @escaping MangaCompletionHandler) -> Void
}

class GGLMangaService: MangaServiceProtocol {
    
    // API provider
    let provider = MoyaProvider<GGLService>()
    
    // server API
    func fetchMangasAPI(completionHandler: @escaping MangaCompletionHandler) -> Void {
        self.provider.request(.showMangas) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.map(Manga.self)
                    let statusCode = moyaResponse.statusCode
                    print("statusCode:\(statusCode)")
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
