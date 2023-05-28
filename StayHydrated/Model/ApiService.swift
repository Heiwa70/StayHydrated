//
//  ApiService.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 17/05/2023.
//

import Foundation

struct ApiService {
    enum ApiError: Error{
        case failed
        case failedToDecode
        case invalideStatusCode
        case invalideUserName
    }
    
    func addUser(for user: User) async throws -> User{
        let baseURL = "http://localhost:8888/api.php?func=adduser&"
        let endPoint = baseURL +  "&nom=\(user.nom)&taille=\(user.taille)&poids=\(user.poids)&activite=\(user.activite)&objectif=\(user.objectif)&age=\(user.age)"


        guard let url = URL(string: endPoint) else {
            throw ApiError.invalideUserName
        }

        let (data,response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ApiError.invalideStatusCode
        }

        let decodedData = try JSONDecoder().decode(User.self, from: data)

        return decodedData
    }
    
    
//    func fetchInfo(for username:String) async throws -> FollowerInfo {
//        let baseURL = "https://api.github.com/users/"
//        let endPoint = baseURL + "\(username)"
//
//        guard let url = URL(string: endPoint) else {
//            throw ApiError.invalideUserName
//        }
//
//        let (data,response) = try await URLSession.shared.data(from: url)
//
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
//        {
//            throw ApiError.invalideStatusCode
//        }
//
//        let decodedData = try JSONDecoder().decode(FollowerInfo.self, from: data)
//
//        return decodedData
//
//    }

    
}
