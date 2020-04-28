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
    // MARK: - Properties/Constants
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTavleview()
    }
    
    // MARK: - Required Methods
    private func setupTavleview() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Delegate methods UITableViewDataSource, UITableViewDelegate
extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//viewModel?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = ArticleTableviewCell.cellIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticleTableviewCell
//        let rowData = viewModel?.rowsArray[indexPath.row]
//        cell?.row = rowData
        
        cell?.userName.text = "Chetan"
        cell?.userDesignationLbl.text = "iOS Developer"
        cell?.likeCountLbl.text = "5 Likes"
        cell?.articleDescLbl.text = "5 Likes HJFGDuakjh,d m,avnd abgdjka,mmdb ga kbmd bvada dakjbd badna danb jsgfakj fsjaf as jfajshfkjhasj hf askflaksf ahsfa sf a sfhakjshf af  asf asjf ashjf jasfhkj askfasfahjksf sa f000"
        cell?.commentsCountLbl.text = "10 Comments"
        
        cell?.layer.shouldRasterize = true
        cell?.layer.rasterizationScale = UIScreen.main.scale
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
