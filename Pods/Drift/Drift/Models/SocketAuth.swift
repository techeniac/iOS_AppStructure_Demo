//
//  SocketAuth.swift
//  Drift
//
//  Created by Eoin O'Connell on 31/05/2017.
//  Copyright © 2017 Drift. All rights reserved.
//

struct SocketAuth {
    let sessionToken: String
    let userId: String
    let orgId: Int
}

class SocketAuthDTO: Codable, DTO {
    typealias DataObject = SocketAuth
    
    
    var sessionToken: String?
    var userId: String?
    var orgId: Int?
    
    
    func mapToObject() -> SocketAuth? {
        return SocketAuth(sessionToken: sessionToken ?? "",
                          userId: userId ?? "",
                          orgId: orgId ?? -1)
    }
    
    enum CodingKeys: String, CodingKey {
        case userId         = "user_id"
        case sessionToken   = "session_token"
        case orgId          = "org_id"
    }
}

