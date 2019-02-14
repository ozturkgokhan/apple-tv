//
//  BaseTests.swift
//  Auntie PlayerUITests
//
//  Created by Gokhan Ozturk on 14.02.2019.
//  Copyright © 2019 Matt & Phill Collaboration. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase   {
    
    let app = XCUIApplication()
    let remote: XCUIRemote = XCUIRemote.shared
    
    let defaultLaunchArguments: [[String]] = {
        let launchArguments: [[String]] = [["-StartFromCleanState", "YES"]]
        return launchArguments
    }()
    
    func launchApp(with launchArguments: [[String]] = []) {
        (defaultLaunchArguments + launchArguments).forEach { app.launchArguments += $0 }
        app.launch()
    }
    
    override func setUp() {
        
        super.setUp()
        continueAfterFailure = false
        launchApp(with: defaultLaunchArguments)
    }
    
    override func tearDown() {
        let screenshot = XCUIScreen.main.screenshot()
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
        fullScreenshotAttachment.lifetime = .deleteOnSuccess
        add(fullScreenshotAttachment)
        app.terminate()
        super.tearDown()
    }
    
}

