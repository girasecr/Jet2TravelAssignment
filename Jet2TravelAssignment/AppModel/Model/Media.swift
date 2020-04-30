//
//  Media.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 30/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import CoreData

class Media: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case blogID
        case createdAt
        case image
        case title
        case url
    }
    
    // MARK: - Core Data Managed Object
    @NSManaged var id: String?
    @NSManaged var blogID: String?
    @NSManaged var createdAt: String?
    @NSManaged var image: String?
    @NSManaged var title: String?
    @NSManaged var url: String?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Media", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.blogID = try container.decodeIfPresent(String.self, forKey: .blogID)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(blogID, forKey: .blogID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(image, forKey: .image)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
    }
}
