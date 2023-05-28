//
//  UseViewModel.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 28/05/2023.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    enum State {
        case notAvailable
        case loading
        case success(data: User)
//        case success_info(data: FollowerInfo)
        case failed(error: Error)
    }
    
    @Published var state: State = .notAvailable
    
    private let service: ApiService = ApiService()
    
    func addUser(from user: User) async {
        self.state = .loading
        do {
            let adduser = try await service.addUser(for : user)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
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
