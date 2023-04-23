//
//  APIManager.swift
//  5th task
//
//  Created by Владимир Курганов on 20.11.2022.
//

import Foundation
import UIKit
import FirebaseFirestore

// MARK: - APIManagerProtocol
protocol APIManagerProtocol: AnyObject {
    func getData(collection: String, completion: @escaping([QueryDocumentSnapshot]?) -> Void)
    func setData(user: MWUserModel, completion: @escaping(Result<MWUserModel, Error>) -> Void)
    func getDocument(docName: String, completion: @escaping(MWUserModel?) -> Void)
    func deleteDocument(docName: String)
}

// MARK: - APIManager
final class APIManager {
    
    // MARK: - Properties
    private var usersRef: CollectionReference {
        let dataBase = configureFB()
        return dataBase.collection("Players")
    }
    
    private func configureFB() -> Firestore {
        var dataBase: Firestore?
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase!
    }
}

// MARK: - Extension
extension APIManager: APIManagerProtocol {
    func getData(collection: String, completion: @escaping([QueryDocumentSnapshot]?) -> Void) {
        usersRef.getDocuments { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)");
            } else {
                completion(querySnapshot!.documents)
            }
        }
    }
    
    func setData(user: MWUserModel, completion: @escaping(Result<MWUserModel, Error>) -> Void) {
        usersRef.document(user.name).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getDocument(docName: String, completion: @escaping(MWUserModel?) -> Void) {
        usersRef.document(docName).getDocument(completion: { document, error in
            guard error == nil else { completion(nil); return }
            let doc = MWUserModel(name: document?.get("name") as? String ?? "", score: document?.get("score") as? Int ?? 0, id: document?.get("id") as? String ?? "")
            completion(doc)
        })
    }
    
    func deleteDocument(docName: String) {
//        let dataBase = configureFB()
        usersRef.document(docName).delete()
    }
}

