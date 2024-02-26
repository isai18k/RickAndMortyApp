//
//  CharacterSearchView.swift
//  RickAndMortyApp
//
//  Created by Jorge Isai Garcia Reyes on 25/02/24.
//

import SwiftUI
import SwiftUIX
import Kingfisher
import RickMortySwiftApi

struct CharacterSearchView: View {
    @StateObject var presenter = CharacterSearchPresenter()
    @State private var searchText = ""

    var body: some View {
        CharacterSearchViewContent(characters: $presenter.characters, searchText: $searchText)
            .onAppear {
                presenter.fetchCharacters()
            }
    }
}

struct CharacterSearchViewContent: View {
    @Binding var characters: [RMCharacterModel]
    @Binding var searchText: String

    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $searchText)
                ForEach(filteredCharacters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        HStack {
                            KFImage(URL(string: character.image))
                                .placeholder {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                }
                                .onFailure { error in
                                    print("Image failed to load: \(error)")
                                }
                                .fade(duration: 0.25)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                            Text(character.name)
                        }
                    }
                }
            }
            .navigationTitle("Search Characters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var filteredCharacters: [RMCharacterModel] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

