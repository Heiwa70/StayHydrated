//
//  ApiService.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 17/05/2023.
//

import Foundation
import SwiftUI

struct ApiService {
    enum ApiError: Error{
        case failed
        case failedToDecode
        case invalideStatusCode
        case invalideUserName
    }
    
    func addUser(for user: User) async throws -> String{
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

        let decodedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
        if let id = decodedData?["id"] as? String {
            return id
        } else {
            return "-1"
        }
    }
    
    func getUser() async throws -> User {
        @AppStorage("localStorageID") var localStorageID: String = ""
        print(localStorageID)

        let baseURL = "http://localhost:8888/api.php?func=getuser&"
        let endPoint = "\(baseURL)id=\(localStorageID)"
        print(endPoint)
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
    
    func updateUser(for user: User) async throws -> String {
        let baseURL = "http://localhost:8888/api.php?func=updateuser"

        let endPoint  = "\(baseURL)&id=\(user.id_user)&nom=\(user.nom)&taille=\(user.taille.description)&poids=\(user.poids.description)&activite=\(user.activite)&objectif=\(user.objectif)"

        print(endPoint)
        guard let url = URL(string: endPoint) else {
            throw ApiError.invalideUserName
        }

        let (data,response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ApiError.invalideStatusCode
        }

        let decodedData = try JSONDecoder().decode(String.self, from: data)

        return decodedData
    }
    
    func addStat(for stat:Stat) async throws -> String {
        let baseURL = "http://localhost:8888/api.php?func=addstat"

        let endPoint  = "\(baseURL)&id=\(stat.id_user)&quantite=0&jour1=\(stat.jour1)&jour2=\(stat.jour2)&jour3=\(stat.jour3)&jour4=\(stat.jour4)&jour5=\(stat.jour5)&jour6=\(stat.jour6)&jour7=\(stat.jour7)"

        print(endPoint)
        guard let url = URL(string: endPoint) else {
            throw ApiError.invalideUserName
        }

        let (data,response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ApiError.invalideStatusCode
        }

        let decodedData = try JSONDecoder().decode(String.self, from: data)

        return decodedData
    }
    
    func updateStat(for stat:Stat) async throws -> String {
        let baseURL = "http://localhost:8888/api.php?func=updatestat"

        let endPoint  = "\(baseURL)&id=\(stat.id_user)&quantite=0&jour1=\(stat.jour1)&jour2=\(stat.jour2)&jour3=\(stat.jour3)&jour4=\(stat.jour4)&jour5=\(stat.jour5)&jour6=\(stat.jour6)&jour7=\(stat.jour7)"

        print(endPoint)
        guard let url = URL(string: endPoint) else {
            throw ApiError.invalideUserName
        }

        let (data,response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ApiError.invalideStatusCode
        }

//        let decodedData = try JSONDecoder().decode(String.self, from: data)

        return "OK"
    }
    
    func getStat(for id : String) async throws -> Stat {
        let baseURL = "http://localhost:8888/api.php?func=getstat"

        let endPoint  = "\(baseURL)&id=\(id)"

        print(endPoint)
        guard let url = URL(string: endPoint) else {
            throw ApiError.invalideUserName
        }

        let (data,response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ApiError.invalideStatusCode
        }

        let decodedData = try JSONDecoder().decode(Stat.self, from: data)

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
