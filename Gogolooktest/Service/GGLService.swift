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
    // 取得 ggl bo 資訊
    case showGGLBos(type: String, page: Int, subtype: String)
}

// MARK: - TargetType Protocol Implementation
extension GGLService: TargetType {
    
    var baseURL: URL { URL(string: "https://api.jikan.moe/v3/top")! }
    
    var path: String {
        switch self {
            // 取得 GGL bo 資訊 API
        case .showGGLBos(let type, let page, let subtype):
            var path = "/\(type)/\(page)"
            if !subtype.isEmpty {
                path += "/\(subtype)"
            }
            
            return path
        }
    }
    
    // request 方法
    var method: Moya.Method {
        switch self {
        case .showGGLBos:
            return .get
        }
    }
    
    // request 任務
    var task: Task {
        switch self {
        case .showGGLBos:
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
