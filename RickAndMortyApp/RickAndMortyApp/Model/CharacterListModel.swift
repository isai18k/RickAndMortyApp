//
//  CharacterListModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Isai Garcia Reyes on 25/02/24.
//

import RickMortySwiftApi

class CharacterListModel {
    public var rmClient = RMClient()

    func fetchCharacters(completion: @escaping ([RMCharacterModel]) -> Void) {
        Task {
            do {
                let characters = try await rmClient.character().getAllCharacters()
                completion(characters)
            } catch {
                print("Error fetching characters: \(error)")
                completion([])
            }
        }
    }
}
