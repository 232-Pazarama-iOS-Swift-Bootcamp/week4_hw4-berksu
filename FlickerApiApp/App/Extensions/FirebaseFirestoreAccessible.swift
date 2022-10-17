//
//  FirebaseFirestoreAccessible.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 17.10.2022.
//

import Foundation
import FirebaseFirestore

protocol FireBaseFireStoreAccessible {}

extension FireBaseFireStoreAccessible {
    var db: Firestore {
        Firestore.firestore()
    }
}
