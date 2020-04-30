//
//  Article+CoreDataModel.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 30/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import UIKit
import CoreData

class ArticleCoreData {
    static var appDelegate: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
    static func insertIntoCoreData(data: Data) -> [Article]? {
        DispatchQueue.main.sync {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedContext
            let article = try? decoder.decode([Article].self, from: data)
            try? managedContext.save()
            return article
        }
    }
    
    
    static func fetchFromStorage() -> [Article]? {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
        let idSort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [idSort]
        let articles = try? managedContext.fetch(fetchRequest)
        return articles
    }
}
