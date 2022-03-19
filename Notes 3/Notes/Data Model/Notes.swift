//
//  Notes.swift
//  BrickNote
//
//  Created by Mikhail Kim on 06.12.2021.
//


//import Foundation
//import Alamofire
//import SwiftyJSON
//
//final class Notes {
//
//    private let apiVersion = "5.92"
//
//    private func makeComponents(for path: NetworkPaths) -> URLComponents {
//        let urlComponent: URLComponents = {
//            var url = URLComponents()
//            url.scheme = "https"
//            url.host = "http://194.58.108.107"
//            url.path = "/method/\(path.rawValue)"
//            url.queryItems = [
//                URLQueryItem(name: "access_token", value: Session.shared.token),
//                URLQueryItem(name: "v", value: apiVersion),
//            ]
//            return url
//        }()
//        return urlComponent
//    }
//
//    func getUserNote completion: @escaping ([NotesTableViewController]?) -> Void) {
//        var urlComponents = makeComponents(for: .getNotesTableViewController)
//        urlComponents.queryItems?.append(contentsOf: [
//            URLQueryItem(name: "fields", value: "photo_200"),
//        ])
//
//        if let url = urlComponents.url {
//            AF
//                .request(url)
//                .responseData { response in
//                    switch response.result {
//                    case .success(let data):
//                        let json = JSON(data)
//                        let usersJSONs = json["response"]["items"].arrayValue
//                        let vkUsers = usersJSONs.map { NotesTableViewController($0) }
//                        DispatchQueue.main.async {
//                            completion(vkUsers)
//                        }
//                    case .failure(let error):
//                        print(error)
//                        completion(nil)
//                    }
//                }
//        }
//    }
//
//    // MARK: Get groups
//    func getUserGroups(completion: @escaping ([VKGroup]?) -> Void) {
//        var urlComponents = makeComponents(for: .getGroups)
//        urlComponents.queryItems?.append(contentsOf: [
//            URLQueryItem(name: "extended", value: "1"),
//        ])
//
//        if let url = urlComponents.url {
//            AF
//                .request(url)
//                .responseData { response in
//                    switch response.result {
//                    case .success(let data):
//                        let json = JSON(data)
//                        let usersJSONs = json["response"]["items"].arrayValue
//                        let vkUsers = usersJSONs.map { VKGroup($0) }
//                        completion(vkUsers)
//                    case .failure(let error):
//                        print(error)
//                        completion(nil)
//                    }
//                }
//        }
//    }
//}


