//
//  ArticleTableviewCellTests.swift
//  Jet2TravelAssignmentTests
//
//  Created by Deskera User Access on 30/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest
@testable import Jet2TravelAssignment

class ArticleTableviewCellTests: XCTestCase {
    // MARK: - Properties
    var articleImageView: UIImageView!
    var tempImageUrl: String = "https://s3.amazonaws.com/uifaces/faces/twitter/joe_black/128.jpg"
    
    // MARK: - Test Cases Life Cycle
    override func setUp() {
        articleImageView = UIImageView()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Table cell profile image test cases
    func testSetImageWithValidUrl() {
        XCTAssertNotNil(tempImageUrl)
        let imageURL = URL(string: tempImageUrl)
        XCTAssertNotNil(imageURL)
        let placeholderImage = UIImage(named: "defaultthumb.png")
        XCTAssertNotNil(placeholderImage)
        self.articleImageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        XCTAssertNotNil(self.articleImageView.image)
    }
    
    func testSetImageWithInvalidUrl() {
        let invalidUrl = "https://testinvalidurl"
        XCTAssertNotNil(invalidUrl)
        let imageURL = URL(string: invalidUrl)
        XCTAssertNotNil(imageURL)
        let placeholderImage = UIImage(named: "defaultthumb.png")
        XCTAssertNotNil(placeholderImage)
        self.articleImageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        XCTAssertNotNil(self.articleImageView.image)
    }
}
