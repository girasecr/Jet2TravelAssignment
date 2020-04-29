//
//  ArticleTableviewCell.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 28/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ArticleTableviewCell: UITableViewCell {
    // MARK: - Properties/Constants
    struct CONSTANTS {
        static let cellIdentifier = "ArticleTableviewCell"
        static let likes = "Likes"
        static let comments = "Comments"
    }
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userDesignationLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescLbl: UILabel!
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var commentsCountLbl: UILabel!
    @IBOutlet weak var articleImageViewHeight: NSLayoutConstraint!
    
    var article: Article? {
        didSet {
            guard let articleItem = article else {return}
            
            //User data binding
            self.bindUserDetails(users: articleItem.user)
            //Media data binding
            self.bindMediaDetails(mediaData: articleItem.media)
            //Content/Likes/Comments binding
            self.articleDescLbl.text = articleItem.content
            self.likeCountLbl.text = formatNumber(articleItem.likes) + " " + CONSTANTS.likes
            self.commentsCountLbl.text = formatNumber(articleItem.comments) + " " + CONSTANTS.comments
            //Date Time Details binding
            self.bindDatetimeDetails(dateValue: articleItem.createdAt)
        }
    }
    
    static func cellIdentifier() -> String {
        return CONSTANTS.cellIdentifier
    }
    
    // MARK: - View's Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUIViews()
    }
    
    // MARK: - Private Methods
    private func decorateUIViews() {
        userImageView.layer.cornerRadius = userImageView.frame.size.height/2
        userImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = CGFloat(GLOBAL_CONSTANTS.articleCornerRadius)
        articleImageView.clipsToBounds = true
    }
    
    private func bindUserDetails(users: [User]) {
        if let user = users.first {
            self.userName.text = user.name
            self.userDesignationLbl.text = user.designation
            
            if let userAvtar = URL(string: user.avatar) {
                self.userImageView.sd_setImage(with: userAvtar, completed: nil)
            }
            else {
                self.userImageView.image = nil
            }
        }
    }
    
    private func bindMediaDetails(mediaData: [Media]) {
        if let media = mediaData.first {
            if let articleImageURL = URL(string: media.image) {
                self.articleImageViewHeight.constant = CGFloat(GLOBAL_CONSTANTS.deafultImageViewHeight)
                self.articleImageView.sd_setImage(with: articleImageURL, placeholderImage: UIImage(named: "defaultthumb"))
            }
        }
        else {
            self.articleImageView.image = nil
            self.articleImageViewHeight.constant = 0
        }
    }
    
    private func bindDatetimeDetails(dateValue: String) {
        if let date = getDateFrom(dateString: dateValue) {
            let dateTime = getTimeBetween(date, end: Date())
            self.dateTimeLbl.text = dateTime ?? ""
        }
    }
}
