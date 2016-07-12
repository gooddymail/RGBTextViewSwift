//
//  RGBTextViewSwiftTests.swift
//  RGBTextViewSwiftTests
//
//  Created by Katchapon Poolpipat on 7/11/2559 BE.
//  Copyright © 2559 Katchapon Poolpipat. All rights reserved.
//

import XCTest
@testable import RGBTextViewSwift

class RGBTextViewSwiftTests: XCTestCase {
    
    let textView: RGBTextView = RGBTextView()
    let maximumCharacter = 150
    
    override func setUp() {
        super.setUp()
        textView.minHeight = 30.0
        textView.maxHeight = 150.0
        textView.maximumCharacter = maximumCharacter
        textView.text = "http://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextviewhttp://stackoverflow.com/questions/24074955/designated-initializer-of-uitextview"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasHeightConstraint() {
        var heightConstraint: NSLayoutConstraint?
        
        for constraint in textView.constraints {
            
            if constraint.relation == .Equal {
                heightConstraint = constraint
            }
            
        }
        
        if heightConstraint != nil {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false, "Text view must have height constraint")
        }
        
    }
    
    func testHeightConstraintNotOverMaxHeight() {
        
        var heightConstraint: NSLayoutConstraint?
        
        for constraint in textView.constraints {
            
            if constraint.relation == .Equal {
                heightConstraint = constraint
            }
            
        }
        
        XCTAssertTrue(heightConstraint!.constant <= 150, "Height Constraint should not over \(textView.maxHeight) but it \(heightConstraint?.constant)")
        
    }
    
    func testIsTextInTextViewOverMaximumCharacter() {
        XCTAssertTrue(textView.text.characters.count == maximumCharacter, "Text should not over \(maximumCharacter) but it \(textView.text.characters.count)")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
