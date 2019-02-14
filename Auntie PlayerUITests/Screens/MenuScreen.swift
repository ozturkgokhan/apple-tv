//
//  MenuScreen.swift
//  Auntie PlayerUITests
//
//  Created by Gokhan Ozturk on 15.02.2019.
//  Copyright © 2018 Matt & Phill Collaboration. All rights reserved.
//

import XCTest

class MenuScreen: BaseScreen {

    lazy var home = app.tabBars["Menu"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".scrollViews.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    lazy var categories = app.tabBars["Menu"].buttons["Categories"]
    lazy var live = app.tabBars["Menu"].buttons["Live"]
    lazy var search = app.tabBars["Menu"].buttons["Search"]
    
    func navigateToMenuItem(menuElement: XCUIElement){
        waitUntilElementVisible(menuElement)
        findInRow(menuElement)
    }
}
