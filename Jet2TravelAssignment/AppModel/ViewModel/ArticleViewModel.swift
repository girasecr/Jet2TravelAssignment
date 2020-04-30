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
    var dataModel: [Article]?
    let reachability = try? Reachability()
    weak var reachabilityDelegate: ReachabilityProtocol?
    var updateUI: () -> Void = { }
    var numberOfRows: Int = 0
    var articleArray: [Article] = []
    
    init() {
        loadApiData()
    }
    
    // MARK: - Required Methods
    func loadApiData() {
        self.getApiData(complete: { [weak self] (dataModel) in
            self?.prepareData()
        })
    }
    
    private func prepareData() {
        self.dataModel = ArticleCoreData.fetchFromStorage()
        self.preparedTableCellCount()
        self.updateUI()
    }
    
    private func preparedTableCellCount() {
        self.articleArray = self.dataModel ?? []
        self.numberOfRows = self.articleArray.count > 0 ? GLOBAL_CONSTANTS.loadMorePageSize : 0
    }
    
    func getApiData(complete:@escaping ([Article]?) -> Void) {
        let apiConfiguration = APIConfiguration(httpMethod: .get)
        RequestManager.sharedInstance.withGet(apiConfiguration: apiConfiguration) { json, _ in
            if let response = json {
                let jsonData = response.data(using: .utf8)!
                let articleDataModel = ArticleCoreData.insertIntoCoreData(data: jsonData)
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

