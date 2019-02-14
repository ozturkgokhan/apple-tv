//
//  Home.swift
//  Auntie PlayerUITests
//
//  Created by Gokhan Ozturk on 14.02.2019.
//  Copyright © 2019 Matt & Phill Collaboration. All rights reserved.
//

import XCTest

class ContentTests: BaseTest {
    
    let homeScreen = HomeScreen()
    let menu = MenuScreen()
    let contentScreen = ContentScreen()
    
    func test_FindContentAtMainScreenAndCheckItIsDisplayedProperlyAtContentScreen(){
        let contentName = "Les Miserables"
        
        if menu.home.hasFocus {
            homeScreen.waitUntilElementVisible(homeScreen.grid)
            
            while !homeScreen.grid.children(matching:.any).element(boundBy: 0).hasFocus {
                remote.press(.select)
            }
            
            homeScreen.findSpecifiedInGrid(contentName)
            
            contentScreen.checkContentTitle(contentName)
        }
    }
}
