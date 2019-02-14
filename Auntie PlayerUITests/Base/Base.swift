//
//  Base.swift
//  Auntie PlayerUITests
//
//  Created by Gokhan Ozturk on 15.02.2019.
//  Copyright © 2019 Matt & Phill Collaboration. All rights reserved.
//

import XCTest

protocol BaseScreen {
    
}

let app = XCUIApplication()
let remote: XCUIRemote = XCUIRemote.shared

extension XCUIElement {
    var details: String {
        let regex = try! NSRegularExpression(pattern: "0x\\S+",
                                             options: .caseInsensitive)
        return regex.stringByReplacingMatches(in: debugDescription,
                                              options: [], range: NSMakeRange(0, debugDescription.count),
                                              withTemplate: "")
    }
}

extension BaseScreen {
    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        return app.descendants(matching: type)
    }
    
    func getElementLabel(_ element: XCUIElement) -> String {
        return element.label
    }
    
    func waitUntilElementVisible(_ element: XCUIElement){
        let predicate = NSPredicate.init(format: "visible == true")
        let expectation = XCTNSPredicateExpectation.init(predicate: predicate, object: element)
        
        XCTWaiter().wait(for: [expectation], timeout: 2)
    }
    
    func moveFocusVertical(_ isEndReached: Bool) {
        remote.press(isEndReached ? .up : .down)
    }
    
    func moveFocusHorizontal(_ isMovingRight: Bool) {
        remote.press(isMovingRight ? .right : .left)
    }
    
    func findInRow(_ element: XCUIElement) {
        var isEndReached = false
        while !element.exists || !element.hasFocus {
            let previous: String = focused.details
            moveFocusHorizontal(isEndReached)
            let current: String = focused.details
            if previous == current {
                if isEndReached {
                    XCTFail("Element \(element) was not" +
                        " found in row or could not be focused")
                }
                isEndReached = true
            }
        }
        print("Element \(element) was found and focused")
        remote.press(.select)
    }
    
    var focused: XCUIElement {
        return app.descendants(matching: .any)
            .element(matching: NSPredicate(format: "hasFocus == true"))
    }
    
    func findInColumn(_ element: XCUIElement) -> String {
        var isEndReached = false
        while !element.exists || !element.hasFocus {
            let previous: String = focused.details
            moveFocusVertical(isEndReached)
            let current: String = focused.details
            if previous == current {
                if isEndReached {
                    XCTFail("Element \(element) was not" +
                        " found in column or could not be focused")
                }
                isEndReached = true
            }
        }
        print("Element \(element) was found and focused")
        //remote.press(.select)
        return element.staticTexts.element(boundBy: 0).label
    }
    
    func findInGrid(_ element: XCUIElement) {
        var isMovingRight = true
        var current: String
        var previous: String? = nil
        var isEndReached = false
        
        while !element.exists || !element.hasFocus {
            
            // Slower execution to observes running tests on GUI
            let second: Double = 1000000
            usleep(useconds_t(0.02 * second)) //will sleep for 20 milliseconds (.02 seconds)
            
            moveFocusHorizontal(isMovingRight)
            current = focused.details
            
            if current == previous {
                remote.press(.down)
                isMovingRight = !isMovingRight
                current = focused.details
                
                if current == previous {
                    if isEndReached {
                        XCTFail("Element \(element) was not" +
                            " found in the grid")
                    } else {
                        isEndReached = true
                    }
                }
            }
            previous = current
        }
        print("Element \(element) was found!")
        remote.press(.select)
    }
    
    
    
    func findSpecifiedInGrid(_ title: String) {
        var isMovingRight = true
        var current: String
        var previous: String? = nil
        var isEndReached = false
        
        var element: XCUIElement
        
        element = focused
        
        while 1 == 1 {
            
            // Slower execution to observes running tests on GUI
            let second: Double = 1000000
            usleep(useconds_t(0.02 * second)) //will sleep for 20 milliseconds (.02 seconds)
            
            if element.staticTexts.element(boundBy: 0).label != title {
                
                moveFocusHorizontal(isMovingRight)
                current = focused.details
                
                
                if current == previous {
                    remote.press(.down)
                    isMovingRight = !isMovingRight
                    current = focused.details
                    
                    
                    if current == previous {
                        if isEndReached {
                            XCTFail("Element \(focused) was not" +
                                " found in the grid")
                        } else {
                            isEndReached = true
                        }
                    }
                }
                previous = current
            }
            else{
                print("Element \(focused) was found!")
                remote.press(.select)
                sleep(5)
                break;
            }
        }
        
    }
}
