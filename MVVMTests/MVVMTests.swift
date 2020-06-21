//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Usemobile on 18/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {

    func testExample() {
        let mainController = MainTableViewController()
        mainController.articleLoader = ArticleLoaderSpy()
        mainController.loadViewIfNeeded()
        XCTAssertEqual(mainController.tableView.numberOfRows(inSection: 0), 1)
        
        let dataSource = mainController.tableView.dataSource
        let cell = dataSource?.tableView(mainController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! GoTCell
        
        XCTAssertEqual(cell.textLabel?.text, "A Title")
    }
    
    func test_mainTableController_presentsDetailsForSelectedCell() {
        var presentDetails = false
        let mainController = MainTableViewController()
        mainController.presentDetails = { _ in
            presentDetails = true
        }
        mainController.articleLoader = ArticleLoaderSpy()
        mainController.loadViewIfNeeded()
        
        mainController.simulateCellTap()
        
        XCTAssertTrue(presentDetails)
    }
    
    final class ArticleLoaderSpy: ArticleLoader {
        func loadArticle(completion: @escaping (Result<ArticleResponse, Error>) -> Void) {
            completion(.success(
                ArticleResponse(
                    items: [
                        Article(title: "A Title",
                                thumbnail: "A thumbnail",
                                abstract: "A abstract",
                                url: "http://a-url.com")])))
        }
    }

}

extension MainTableViewController {
    
    func simulateCellTap() {
        let delegate = self.tableView.delegate
        delegate?.tableView?(self.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
}
