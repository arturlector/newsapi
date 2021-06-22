//
//  Group.swift
//  vk-junior
//
//  Created by Artur Igberdin on 22.06.2021.
//

import Foundation
import RealmSwift

struct GroupList: Codable {
    let response: GroupResponse
}
struct GroupResponse: Codable {
    let count: Int?
    let items: [Group]
}
class Group: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo: String
    
    enum CodingKeys: String, CodingKey {
        case name, id
        case photo = "photo_100"
    }
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toFirestore() -> [String: Any] {
        return [String(id) : name]
    }
}
