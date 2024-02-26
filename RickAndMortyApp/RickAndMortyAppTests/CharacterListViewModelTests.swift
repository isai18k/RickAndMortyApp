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
    
    func testFetchCharacters() {
        let viewModel = CharacterSearchPresenter()
        viewModel.fetchCharacters()
        // Add assertions based on the expected behavior of fetchCharacters() method
    }
    
    func testCharacterListPresenterFetchCharacters() {
           // Given
           let presenter = CharacterListPresenter()
           
           // When
           presenter.fetchCharacters()
           
           // Then
           // Assert the expected behavior after fetching characters
           // For example, you can assert that the characters array is not empty or any other expected behavior
           //XCTAssertFalse(presenter.characters.isEmpty)
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
        //XCTAssertEqual(contentView.navigationTitle, "RICK AND MORTY CHARACTERS")
    }
    
}

class CharacterSearchViewTests: XCTestCase {
    // Write tests for CharacterSearchView
}

class CharacterDetailViewTests: XCTestCase {
    // Write tests for CharacterDetailView
}
