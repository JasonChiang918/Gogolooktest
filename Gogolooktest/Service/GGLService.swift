//
//  GGLService.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import Foundation
import Moya

// Server API
enum GGLService {
    // 取得 Anime 資訊
    case showAnimes
    
    // 取得 Manga 資訊
    case showMangas
}

// MARK: - TargetType Protocol Implementation
extension GGLService: TargetType {
    
    var baseURL: URL { URL(string: "https://api.jikan.moe/v3/top")! }
    
    var path: String {
        switch self {
            // 取得 Anime 資訊 API
        case .showAnimes:
            return "/anime"
            // 取得 Manga 資訊 API
        case .showMangas:
            return "/manga"
        }
    }
    
    // request 方法
    var method: Moya.Method {
        switch self {
        case .showAnimes, .showMangas:
            return .get
        }
    }
    
    // request 任務
    var task: Task {
        switch self {
        case .showAnimes, .showMangas:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
