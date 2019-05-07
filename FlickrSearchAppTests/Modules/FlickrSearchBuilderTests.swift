//
//  FlickrSearchBuilderTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import FlickrSearchApp

final class FlickrSearchBuilderTests: XCTestCase {

    var viewController: FlickrSearchViewController!
    var presenter: FlickrSearchPresenter!
    var interactor: FlickrSearchIneractor!
    var router: FlickrSearchRouter!
    
    override func setUp() {
        super.setUp()
        let moduleBuilder = FlickrSearchModuleBuilder()
        viewController = moduleBuilder.buildModule()
        presenter = viewController.presenter as? FlickrSearchPresenter
        interactor = presenter.interactor as? FlickrSearchIneractor
        router = presenter.router as? FlickrSearchRouter
    }

    override func tearDown() {
        viewController = nil
        presenter = nil
        interactor = nil
        router = nil
    }

    func testFlickrModuleBuilder() {
        XCTAssertTrue(viewController != nil)
        XCTAssertTrue(presenter != nil)
        XCTAssertTrue(interactor != nil)
        XCTAssertTrue(router != nil)
    }
    
    func testFlickrModuleViewController() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.presenter)
        XCTAssertTrue(viewController.presenter is FlickrSearchPresenter)
    }

    func testFlickrSearchModulePresenter() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertTrue(presenter.view is FlickrSearchViewController)
        XCTAssertTrue(presenter.interactor is FlickrSearchIneractor)
        XCTAssertTrue(presenter.router is FlickrSearchRouter)
    }
    
    func testFlickrSearchModuleInteractor() {
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor.presenter)
        XCTAssertTrue(interactor.presenter is FlickrSearchPresenter)
    }
}
