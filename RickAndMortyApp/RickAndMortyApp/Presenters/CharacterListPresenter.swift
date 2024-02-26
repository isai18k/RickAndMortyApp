//
//  CharacterListPresenter.swift
//  RickAndMortyApp
//
//  Created by Jorge Isai Garcia Reyes on 25/02/24.
//

import SwiftUI
import RickMortySwiftApi

class CharacterListPresenter: ObservableObject {
    private let model = CharacterListModel()
    
    @Published var characters: [RMCharacterModel] = []
    
    func fetchCharacters() {
        model.fetchCharacters { characters in
            DispatchQueue.main.async {
                self.characters = characters
            }
        }
    }
}
