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
    
    func fetchFollowers(for username: String, page: Int) async throws -> [User] {
        let baseURL = "https://api.github.com/users/"
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            throw ApiError.invalideUserName
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ApiError.invalideStatusCode
        }
        
        let decodedData = try JSONDecoder().decode([User].self, from: data)
        
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
