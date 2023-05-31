//
//  UseViewModel.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 28/05/2023.
//

import Foundation
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @AppStorage("localStorageID") var localStorageID: String = ""

    enum State {
        case notAvailable
        case loading
        case success(data: User)
//        case success_info(data: FollowerInfo)
        case failed(error: Error)
    }
    enum ApiError: Error {
            case failed
            case failedToDecode
            case invalideStatusCode
            case invalideUserName
        }
    
    @Published var state: State = .notAvailable
    
    private let service: ApiService = ApiService()
    
    func addUser(from user: User) async -> String {
        var id : String = "-1"
        self.state = .loading
        do {
            id = try await service.addUser(for : user)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
        return id
    }
    
    func getUser() async {
        
        self.state = .loading
        do {
            let user = try await service.getUser()
            self.state = .success(data: user)
        }
        catch {
            self.state = .failed(error: error)
            print(error)
        }
//        let baseURL = "http://localhost:8888/api.php"
//        let endpoint = baseURL + "?func=getuser&id=" + localStorageID
//        print(endpoint)
//        guard let url = URL(string: endpoint) else {
//            throw ApiError.invalideUserName
//        }
//
//        let (data, response) = try await URLSession.shared.data(from: url)
//
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw ApiError.invalideStatusCode
//        }
//
//        do {
//            let decodedData = try JSONDecoder().decode(User.self, from: data)
//            self.State = .success(data: decodedData)
//            return decodedData
//        } catch {
//            // Affichez les informations de débogage pour comprendre la cause de l'erreur
//            print("Erreur de décodage JSON: \(error)")
//            throw ApiError.failedToDecode
//        }
    }
    
    
    
//    func getFollowers(from userName: String, page: Int) async {
//        self.state = .loading
//        do {
//            let followers = try await service.fetchFollowers(for: userName, page: page)
//            self.state = .success(data: followers)
//        } catch {
//            self.state = .failed(error: error)
//            print(error)
//        }
//    }
    
//    func getInfoFollower(from userName: String) async {
//        self.state = .loading
//        do{
//            let followerInfo = try await service.fetchInfo(for: userName)
//            self.state = .success_info(data: followerInfo)
//        }catch{
//            self.state = .failed(error: error)
//            print(error)
//        }
//    }
}
