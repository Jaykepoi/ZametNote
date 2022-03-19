//
//  Session.swift
//  BrickNote
//
//  Created by Mikhail Kim on 06.12.2021.
//

import Foundation

class Session {
    public static let shared = Session()
    
    var id = 0
    var token = ""
    var longPoll = LongPoll()
    
    var stringId: String {
        return String(id)
    }
    
    private init() { }
    
    struct LongPoll {
        var server = ""
        var ts: TimeInterval = 0
        var pts: Int = 0
        var key = ""
    }
}
