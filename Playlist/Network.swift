//
//  Network.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 19/07/22.
//

import Foundation

enum UserError: Error {
    case badURL, noData, invalidJSON
}

class Network {
    
    static let shared = Network()
    
    enum UrlEndpoint: String {
            case api = "http://localhost:8080/"
    }
    enum Endpoint: String {
        case user = "user"
        case music = "music"
    }
    
    func fetchUsers(name: String,
                    username: String,
                    completion: @escaping (Result<[User]?, UserError>) -> Void) {
        guard let url = URL(string: UrlEndpoint.api.rawValue + Endpoint.user.rawValue) else {
            completion(.failure(.badURL))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode([User].self, from: data)
                completion(.success(result))
                debugPrint(result)
            } catch {
                completion(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
    
    func postUser(name: String, username: String) {
        guard let url = URL(string: "http://localhost:8080/user") else {
            return
        }

        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: AnyHashable] = [
                "name": name,
                "username": username,
            ]
            
            let data = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = data
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else {
                    return
                }
                
                switch response.statusCode {
                case 200 ..< 300:
                    debugPrint("Deu bom")
                    
                case 400 ..< 500:
                    debugPrint("StatusCode: \(response.statusCode)")
                    
                default:
                    return
                }
                
            }
            
            //let task = URLSession.shared.dataTask(with: request)
            task.resume()
        }
        
    }
                            
}
