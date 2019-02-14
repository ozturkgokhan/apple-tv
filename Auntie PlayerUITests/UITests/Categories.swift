//
//  Categories.swift
//  Auntie PlayerUITests
//
//  Created by Gokhan Ozturk on 14.02.2019.
//  Copyright © 2019 Matt & Phill Collaboration. All rights reserved.
//

import XCTest

class Categories: BaseTest {
    
    let categoriesScreen = CategoriesScreen()
    let menu = MenuScreen()
    
    func test_FindContentAtCategories(){
        let index = 8
        let title = "Food"
        menu.navigateToMenuItem(menuElement: menu.categories)
        let result = categoriesScreen.findInColumn(categoriesScreen.categoriesList.children(matching:.any).element(boundBy: index))
            
        XCTAssertEqual(result == title, true)
    }
}
