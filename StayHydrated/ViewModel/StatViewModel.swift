//
//  StatViewModel.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 31/05/2023.
//

import Foundation
import SwiftUI

@MainActor
class StatViewModel: ObservableObject {
    @AppStorage("localStorageID") var localStorageID: String = ""

    enum State {
        case notAvailable
        case loading
        case success(data: Stat)
        case successAddStat
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
    
    func addStat(from stat: Stat) async -> String {
        var id : String = "1"
        self.state = .loading
        do {
            id = try await service.addStat(for : stat)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
        return id
    }
    
    func updateStat(from stat:Stat) async {
        do {
            let result = try await service.updateStat(for : stat)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
    
    func getStat(from id : String) async {
        self.state = .loading
        do {
            let result = try await service.getStat(for : id)
            self.state = .success(data: result)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
    
    
    
//    func updateUser(user:User) async {
//        self.state = .loading
//        do {
//               let updatedUser = try await service.updateUser(for: user)
//               self.state = .successUpdate
//        } catch {
//            self.state = .failed(error: error)
//            print(error)
//        }
//    }
//    
    
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
