//
//  ContentScreen.swift
//  Auntie PlayerUITests
//
//  Created by Gokhan Ozturk on 15.02.2019.
//  Copyright © 2019 Matt & Phill Collaboration. All rights reserved.
//

import XCTest

class ContentScreen: BaseScreen {
    lazy var contentTitleStaticText = app.staticTexts.firstMatch
    
    func checkContentTitle(_ contentTitle: String) {
        XCTAssertEqual(getElementLabel(contentTitleStaticText) == contentTitle, true)
    }
}
