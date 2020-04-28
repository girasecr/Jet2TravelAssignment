//
//  ArticleViewModel.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 28/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import Reachability

protocol ReachabilityProtocol: NSObjectProtocol {
    func networkConnectionDidConnected()
    func networkConnectionDidDisconnected()
}

class ArticleViewModel {
    // MARK: - Properties
    var dataModel: ArticleDataModel?
    let reachability = try? Reachability()
    weak var reachabilityDelegate: ReachabilityProtocol?
    var updateUI: () -> Void = { }
    var numberOfRows = 0
    var articleArray: [Article] = []
    
    init() {
        loadApiData()
    }
    
    // MARK: - Required Methods
    func loadApiData() {
        self.getApiData(complete: { [weak self] (dataModel) in
            self?.dataModel = dataModel
            self?.preparedTableCellCount()
            self?.updateUI()
        })
    }
    
    private func preparedTableCellCount() {
        self.articleArray = self.dataModel?.articles ?? []
        self.numberOfRows =  self.articleArray.count
    }
    
    func getApiData(complete:@escaping (ArticleDataModel?) -> Void) {
        let apiConfiguration = APIConfiguration(httpMethod: .get)
        RequestManager.sharedInstance.withGet(apiConfiguration: apiConfiguration) { json, _ in
            if let response = json {
                let jsonData = response.data(using: .utf8)!
                let articlesData = try? JSONDecoder().decode([Article].self, from: jsonData)
                let articleDataModel = ArticleDataModel(articles: articlesData ?? [])
                complete(articleDataModel)
            } else {
                complete(nil)
            }
        }
    }
    
    deinit {
        stopReachAabilityNotifier()
    }
}

// MARK: - Reachability Listner Methods
extension ArticleViewModel {
    func addReachabilityNotifier() {
        reachability?.whenReachable = { [weak self] reachability in
            self?.reachabilityDelegate?.networkConnectionDidConnected()
        }
        reachability?.whenUnreachable = {  [weak self] _ in
            self?.reachabilityDelegate?.networkConnectionDidDisconnected()
        }
        do {
            try reachability?.startNotifier()
        } catch {  }
    }
    
    private func stopReachAabilityNotifier() {
        reachability?.stopNotifier()
    }
}

