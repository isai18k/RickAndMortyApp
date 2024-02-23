//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Jorge Isai Garcia Reyes on 21/02/24.
//

import SwiftUI
import SwiftUIX
import RickMortySwiftApi
import Kingfisher

struct CharacterListView: View {
    @StateObject var viewModel = CharacterListViewModel()
    @State private var showMenu = false
    @State private var isSearchViewPresented = false
    

    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ZStack {
               
                Image("RaMBackGround2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                VStack {
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
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                            .stroke(Color.green, lineWidth: 2) // Green border
                                        )
                                    
                                    Text(character.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18))
                                        .lineLimit(2)
                                        .padding(.horizontal, 8)
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: false, vertical: true) // Allow text
                                }
                                .frame(width: 140, height: 150)
                                .background(Color.black.opacity(0.70))
                                .cornerRadius(10)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 2)
                                )
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Rick and Morty Characters")
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
                            }) {
                                Label("About App", systemImage: "flame")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
            }
            .sheet(isPresented: $isSearchViewPresented) {
                CharacterSearchView()
            }
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
        .alert(isPresented: $showMenu) {
            Alert(title: Text("Options"), message: nil, dismissButton: .default(Text("OK")))
        }
    }
}

struct CharacterSearchView: View {
    @StateObject var viewModel = CharacterListViewModel()
        @State private var searchText = ""

        var body: some View {
            NavigationView {
                List {
                    SearchBar(text: $searchText) // Add the search bar
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
            .onAppear {
                viewModel.fetchCharacters()
            }
        }

        // Filter characters based on search query
        private var filteredCharacters: [RMCharacterModel] {
            if searchText.isEmpty {
                return viewModel.characters
            } else {
                return viewModel.characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
}

struct CharacterDetailView: View {
    let character: RMCharacterModel

       var body: some View {
           ScrollView(.vertical, showsIndicators: false, content: {
               GeometryReader{reader in
                   if reader.frame(in: .global).minY > -480 {
                       KFImage(URL(string: character.image))
                           .placeholder {
                               Image(systemName: "person.fill")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 150, height: 150)
                                   .foregroundColor(.gray)
                           }
                           .cacheMemoryOnly(true)
                           .fade(duration: 0.25)
                           .onFailure { error in
                               print("Image failed to load: \(error)")
                           }
                           .resizable()
                           .aspectRatio(contentMode: .fill)
                           .offset(y: -reader.frame(in: .global).minY)
                           .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480)
                   }
                   
               }.frame(height: 480)
               ZStack {
                   // Add Background image
                   Image("detailBackgroundRaM")
                       .resizable()
                       .scaledToFit()
                       .edgesIgnoringSafeArea(.all)
                   VStack(alignment: .leading,spacing: 15){
                       Text(character.name)
                           .font(.system(size: 35, weight: .bold))
                       Text("Status")
                           .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                       Text(character.status)
                           .font(.subheadline)
                           .padding(.bottom,16)
                       Text("Species")
                           .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                       Text(character.species)
                           .font(.subheadline)
                           .padding(.bottom,16)
                       Text("Type")
                           .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                       Text(character.type)
                           .font(.subheadline)
                           .padding(.bottom,16)
                       Text("Gender")
                           .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                       Text(character.gender)
                           .font(.subheadline)
                           .padding(.bottom,16)
                   }
                   .padding(.top, 15)
                   .padding(.horizontal, 80)
                   .background(.green.opacity(0.70))
                   .cornerRadius(20)
                   .offset(y: -35)
               }
           })
           .edgesIgnoringSafeArea(.all)
           .background(Color.black.edgesIgnoringSafeArea(.all))
           .navigationTitle(character.name)
           .navigationBarTitleDisplayMode(.inline)
           
       }
}

class CharacterListViewModel: ObservableObject {
    @Published var characters: [RMCharacterModel] = []
    let rmClient = RMClient()
    
    func fetchCharacters() {
        Task {
            do {
                let characters = try await rmClient.character().getAllCharacters()
                DispatchQueue.main.async {
                    self.characters = characters
                }
            } catch {
                print("Error fetching characters: \(error)")
            }
        }
    }
}
