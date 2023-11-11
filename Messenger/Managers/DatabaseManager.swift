//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Ahmet Tarik DÖNER on 11.11.2023.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

//MARK: - Account Management

extension DatabaseManager {
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
    
    public func isUserExist(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value) {
            snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}

//MARK: - User Struct

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
}
