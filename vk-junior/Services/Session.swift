//
//  Session.swift
//  vk-junior
//
//  Created by Artur Igberdin on 04.06.2021.
//

import Foundation

final class Session {
    static let shared = Session()
    
    private init() {}
    
    var token = ""
    var userId = ""
}
