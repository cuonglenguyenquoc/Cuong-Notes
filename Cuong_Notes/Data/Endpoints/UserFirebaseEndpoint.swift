//
//  UserFirebaseEndpoint.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import UIKit

enum UserFirebaseEndpoint: FirebaseDatabaseEndpoint {
    static let userId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    case getCurrentUserInfo
    case registerNewUser(userName: String)
    
    var path: String {
        switch self {
        case .getCurrentUserInfo:
            return "users/\(Self.userId)"
        case .registerNewUser:
            return "users/\(Self.userId)"
        }
    }
    
    var synced: Bool {
        return true
    }
}
