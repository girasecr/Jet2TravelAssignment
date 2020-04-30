//
//  Article.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 30/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import CoreData

class Article: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case createdAt
        case comments
        case likes
        case media
        case user
    }
    
    // MARK: - Core Data Managed Object
    @NSManaged var id: NSNumber?
    @NSManaged var content: String?
    @NSManaged var createdAt: String?
    @NSManaged var comments: NSNumber?
    @NSManaged var likes: NSNumber?
    @NSManaged var media: Set<Media>?
    @NSManaged var user: Set<User>?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try Int(container.decodeIfPresent(String.self, forKey: .id) ?? "0") as NSNumber?
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.comments = try container.decodeIfPresent(Int.self, forKey: .comments) as NSNumber?
        self.likes = try container.decodeIfPresent(Int.self, forKey: .likes) as NSNumber?
        self.media = try container.decodeIfPresent(Set<Media>.self, forKey: .media)
        self.user = try container.decodeIfPresent(Set<User>.self, forKey: .user)
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id?.intValue, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(comments?.intValue, forKey: .comments)
        try container.encode(likes?.intValue, forKey: .likes)
        try container.encode(media, forKey: .media)
        try container.encode(user, forKey: .user)
    }
}
