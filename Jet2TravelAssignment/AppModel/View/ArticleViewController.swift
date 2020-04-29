//
//  ArticleViewController.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 28/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableIndicatorView: UIActivityIndicatorView!
    var activityIndicatorView: UIActivityIndicatorView?
    var viewModel: ArticleViewModel?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTavleview()
        loadModelData()
    }
    
    // MARK: - Required Methods
    private func setupTavleview() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        setupProcessIndicatorView()
        stopAnimatingLoadMore()
    }
    
    private func setupProcessIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView?.startAnimating()
    }
    
    private func loadModelData() {
        viewModel = ArticleViewModel()
        viewModel?.addReachabilityNotifier()
        viewModel?.reachabilityDelegate = self
        observeEvents()
    }
    
    private func observeEvents() {
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.tableView.reloadData()
                self?.activityIndicatorView?.stopAnimating()
            })
        }
    }
    
    private func startAnimatingLoadMore() {
        self.tableIndicatorView.startAnimating()
        self.tableIndicatorView.isHidden = false
    }
    
    private func stopAnimatingLoadMore() {
        self.tableIndicatorView.stopAnimating()
        self.tableIndicatorView.isHidden = true
    }
}

// MARK: - Delegate methods UITableViewDataSource, UITableViewDelegate
extension ArticleViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = ArticleTableviewCell.cellIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticleTableviewCell
        let articleItem = viewModel?.articleArray[indexPath.row]
        cell?.article = articleItem
        cell?.layer.shouldRasterize = true
        cell?.layer.rasterizationScale = UIScreen.main.scale
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let tableHeight = tableView.bounds.size.height
        let contentHeight = tableView.contentSize.height
        let insetHeight = tableView.contentInset.bottom
        
        let yOffset = tableView.contentOffset.y
        let yOffsetAtBottom = yOffset + tableHeight - insetHeight
        if (yOffsetAtBottom >= contentHeight) && (viewModel?.numberOfRows != viewModel?.articleArray.count) {
            self.startAnimatingLoadMore()
            viewModel?.numberOfRows += GLOBAL_CONSTANTS.loadMorePageSize
            self.tableView.reloadData()
            self.stopAnimatingLoadMore()
        }
    }
}

// MARK: - Reachability Delegate Methods
extension ArticleViewController: ReachabilityProtocol {
    func networkConnectionDidConnected() {
        DispatchQueue.main.async {
            self.viewModel?.loadApiData()
        }
    }
    
    func networkConnectionDidDisconnected() {
        DispatchQueue.main.async {
            self.showNeworkAlert()
        }
    }
    
    func showNeworkAlert() {
        let alert = UIAlertController(title: GLOBAL_CONSTANTS.alertTitle, message: GLOBAL_CONSTANTS.alertMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: GLOBAL_CONSTANTS.alertButtonName, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
