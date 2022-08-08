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
        guard let url = URL(string: UrlEndpoint.api.rawValue + Endpoint.user.rawValue) else {
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
                    // TODO: criar um bloco de @escaping para poder apresentar o lottie de `check`
                    debugPrint("Deu bom")
                    
                case 400 ..< 500:
                    // TODO: criar um bloco de @escaping para poder apresentar um alert contendo uma mensagem de erro
                    debugPrint("StatusCode: \(response.statusCode)")
                    
                default:
                    return
                }
                
            }
            
            task.resume()
        }
    }
        
    func postMusic(id: Int, artist: String, title: String, username: String) {
            guard let url = URL(string: UrlEndpoint.api.rawValue + Endpoint.music.rawValue) else {
                return
            }
            
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let body: [String: AnyHashable] = [
                    "id": id,
                    "artist": artist,
                    "title": title,
                    "username": username
                ]
                
                let data = try? JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = data
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let response = response as? HTTPURLResponse else {
                        return
                    }
                    
                    switch response.statusCode {
                    case 200 ..< 300:
                        debugPrint("Deu bom cadastrar a música")
                        
                    case 400 ..< 500:
                        debugPrint("StatusCode: \(response.statusCode)")
                        
                    default:
                        return
                    }
                    
                }
                
                task.resume()
            }
        }
    
    func fetchMusic(username: String,
                    completion: @escaping (Result<[Music]?, Error>) -> Void) {
        guard let url = URL(string: UrlEndpoint.api.rawValue + "users/" + username + "/\(Endpoint.music.rawValue)" ) else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode([Music].self, from: data)
                completion(.success(result))
                debugPrint(result)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        task.resume()
    }
//    "/music/{username}/{id}"
    func deleteMusic(username: String, id: Int) {
        guard let url = URL(string: UrlEndpoint.api.rawValue + Endpoint.music.rawValue + "/\(username)" + "/\(id)" ) else {
                       return
                   }
                   
                   do {
                       var request = URLRequest(url: url)
                       request.httpMethod = "DELETE"
                       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                       let body: [String: AnyHashable] = [
                           "id": id,
                           "username": username
                       ]
                       
                       let data = try? JSONSerialization.data(withJSONObject: body, options: [])
                       request.httpBody = data
                       
                       let task = URLSession.shared.dataTask(with: request) { data, response, error in
                           guard let response = response as? HTTPURLResponse else {
                               return
                           }
                           
                           switch response.statusCode {
                           case 200 ..< 300:
                               debugPrint("Deu bom deletar a música")
                               
                           case 400 ..< 500:
                               debugPrint("StatusCode: \(response.statusCode)")
                               
                           default:
                               return
                           }
                           
                       }
                       
                       task.resume()
                   }
        
    }
    func updateMusic(id: Int, artist: String, title: String, username: String) {
        guard let url = URL(string: UrlEndpoint.api.rawValue + Endpoint.music.rawValue) else {
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: AnyHashable] = [
                "id": id,
                "artist": artist,
                "title": title,
                "username": username
            ]
            
            let data = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = data
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else {
                    return
                }
                
                switch response.statusCode {
                case 200 ..< 300:
                    debugPrint("Deu bom em atualizar")
                    
                case 400 ..< 500:
                    debugPrint("StatusCode: \(response.statusCode)")
                    
                default:
                    return
                }
                
            }
            
            task.resume()
        }
    }
    
}
