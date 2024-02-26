//
//  CharacterListViewModelTests.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Isai Garcia Reyes on 26/02/24.
//

import XCTest
import SwiftUI
import RickMortySwiftApi
@testable import RickAndMortyApp

class CharacterListViewTests: XCTestCase {
   
    
    // Add more test cases as needed for other functionalities
}

final class CharacterListViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterListPresenterFetchCharacters() {
           // Given
           let presenter = CharacterListPresenter()
           
           // When
           presenter.fetchCharacters()
           
           // Then
           // Assert the expected behavior after fetching characters
           // For example, you can assert that the characters array is not empty or any other expected behavior
           XCTAssertFalse(presenter.characters.isEmpty)
       }
    
    func testCharacterListViewContent() {
        // Given
        let characters: [RMCharacterModel] = [/* Initialize characters for testing */]
        let isSearchViewPresented = false
        let isShowAboutAlert = false
        
        let contentView = CharacterListViewContent(characters: .constant(characters), isSearchViewPresented: .constant(isSearchViewPresented), isShowAboutAlert: .constant(isShowAboutAlert))
        
        // When
        // Simulate the appearance of the view
        
        // Then
        // Assert the expected behavior of the view
        // For example, you can assert that the navigation title is correct, or the content matches the provided characters
//        XCTAssertEqual(contentView.navigationTitle, "RICK AND MORTY CHARACTERS")
//        XCTAssertEqual(contentView.navigationTitle("RICK AND MORTY CHARACTERS"))
    }
    

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
