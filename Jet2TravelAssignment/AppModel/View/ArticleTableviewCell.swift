//
//  ArticleTableviewCell.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 28/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit

class ArticleTableviewCell: UITableViewCell {
    // MARK: - Properties/Constants
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userDesignationLbl: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescLbl: UILabel!
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var commentsCountLbl: UILabel!
    
    struct CONSTANTS {
        static let cellIdentifier = "ArticleTableviewCell"
    }
    
    static func cellIdentifier() -> String {
           return CONSTANTS.cellIdentifier
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUIViews()
    }
    
    private func decorateUIViews() {
        userImageView.layer.cornerRadius = userImageView.frame.size.height/2
        userImageView.clipsToBounds = true
    }
}
