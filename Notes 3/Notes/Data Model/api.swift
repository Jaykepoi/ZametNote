//
//  api.swift
//  BrickNote
//
//  Created by Mikhail Kim on 02.12.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NetworkService {
    
    private let apiVersion = "5.92"
    
    private func makeComponents(for path: Group) -> URLComponents {
        let urlComponent: URLComponents = {
            var url = URLComponents()
            url.scheme = "https"
            url.host = "http://194.58.108.107/api"
            url.path = "/method/\(path.rawValue)"
            url.queryItems = [
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: apiVersion),
            ]
            return url
        }()
        return urlComponent
    }
}
