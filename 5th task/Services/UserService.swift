//
//  UserService.swift
//  5th task
//
//  Created by Владимир Курганов on 23.11.2022.
//

import Foundation

// MARK: - UserServiceProtocol
@objc
protocol UserServiceProtocol {
    func getUserScore(forKey: String) -> Int
    func getUserName(forKey: String) -> String?
    func setData(value: Any, forKey: String)
}

// MARK: - UserService
@objc(UserService)
final class UserService: NSObject {
    
    // MARK: - properties
    @objc static let shared = UserService()
    private let userDefaults = UserDefaults.standard
    
    private override init() { }
}

// MARK: - Extension
extension UserService: UserServiceProtocol {
    @objc
    func getUserName(forKey: String) -> String? {
        userDefaults.object(forKey: forKey) as? String
    }
    
    @objc
    func getUserScore(forKey: String) -> Int {
        userDefaults.object(forKey: forKey) as? Int ?? 0
    }
    
    @objc
    func setData(value: Any, forKey: String) {
        userDefaults.set(value, forKey: forKey)
    }
}
