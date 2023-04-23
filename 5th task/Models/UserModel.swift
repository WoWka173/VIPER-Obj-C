//
//  ModelDB.swift
//  5th task
//
//  Created by Владимир Курганов on 20.11.2022.
//

import Foundation

// MARK: - Model
struct MWUserModel {
    let name: String
    let score: Int
    let id: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["name"] = self.name
        repres["score"] = self.score
        repres["id"] = self.id
        return repres
    }
}

