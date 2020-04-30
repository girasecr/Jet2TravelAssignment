//
//  ArticleViewControllerUnitTests.swift
//  Jet2TravelAssignmentTests
//
//  Created by Deskera User Access on 30/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest
@testable import Jet2TravelAssignment

class ArticleViewControllerUnitTests: XCTestCase {
    // MARK: - Properties/Constants
    var articleController: ArticleViewController!
    struct CONSTANTS {
        static let cellIdentifier = "ArticleTableviewCell"
        static let apiExpectation = "Download Data from server"
    }
    
    // MARK: - UITest Cases Life Cycle
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.articleController = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController
        self.articleController.loadView()
        self.articleController.viewDidLoad()
        let expectation = XCTestExpectation(description: CONSTANTS.apiExpectation)
        self.articleController.viewModel?.getApiData(complete: { (model) in
            XCTAssertNotNil(model, "No data was downloaded.")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: kTimeOut)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Data Tableview Test Cases
    func testHasATableView() {
        XCTAssertNotNil(articleController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(articleController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(articleController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(articleController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(articleController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(articleController.responds(to: #selector(articleController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(articleController.responds(to: #selector(articleController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let index = IndexPath(row: 0, section: 0)
        let cell = articleController.tableView(articleController.tableView, cellForRowAt: index) as? ArticleTableviewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = CONSTANTS.cellIdentifier
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
}
