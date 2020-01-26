//
//  FirestoreManager.swift
//  TravelPlanner
//
//  Created by Thanakorn on 24/1/2563 BE.
//  Copyright © 2563 GAS. All rights reserved.
//

import Firebase

struct FirebaseManager {
    static let db = Firestore.firestore()
    static let root = db.collection(FirestoreKeys.environment).document("data")
    static let storage = Storage.storage()
}
