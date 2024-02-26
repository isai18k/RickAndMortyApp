//
//  CharacterListView.swift
//  RickAndMortyApp
//
//  Created by Jorge Isai Garcia Reyes on 25/02/24.
//

import SwiftUI
import SwiftUIX
import Kingfisher
import RickMortySwiftApi

struct CharacterListView: View {
    @StateObject var presenter = CharacterListPresenter()
    @State private var isSearchViewPresented = false
    @State private var isShowAboutAlert = false

    var body: some View {
        NavigationView {
            CharacterListViewContent(characters: $presenter.characters, isSearchViewPresented: $isSearchViewPresented, isShowAboutAlert: $isShowAboutAlert)
                .onAppear {
                    presenter.fetchCharacters()
                }
        }
        .navigationBarColor(backgroundColor: .black, tintColor: .green)
    }
}

struct CharacterListViewContent: View {
    @Binding var characters: [RMCharacterModel]
    @Binding var isSearchViewPresented: Bool
    @Binding var isShowAboutAlert: Bool
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterCellView(character: character)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .background(
            Image("RaMBackGround2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationTitle("RICK AND MORTY CHARACTERS")
        .navigationBarTitleDisplayMode(.inline)
        .font(.footnote)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        // Action for Search Character
                        isSearchViewPresented = true
                    }) {
                        Label("Search Character", systemImage: "magnifyingglass")
                    }
                    Button(action: {
                        // Action for Option About
                        isShowAboutAlert = true
                    }) {
                        Label("About App", systemImage: "flame")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .accentColor(.purple)
        .sheet(isPresented: $isSearchViewPresented) {
            CharacterSearchView()
        }
        .alert(isPresented: $isShowAboutAlert) {
                       Alert(title: Text("About App"), message: Text("This application was created as a technical test \nby\n Jorge Isaí García Reyes"), dismissButton: .default(Text("OK")))
                   }
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor?, tintColor: UIColor?) -> some View {
        self.modifier(NavigationBarColorModifier(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}

struct NavigationBarColorModifier: ViewModifier {
    init(backgroundColor: UIColor?, tintColor: UIColor?) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}

