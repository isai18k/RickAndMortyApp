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

    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    HStack {
                        KFImage(URL(string: character.image)) // Use KFImage instead of AsyncImage
                            .placeholder{
                                Image(systemName: "person.fill")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 50, height: 50)
                                                        .foregroundColor(.gray)
                            }
                            .onFailure { error in
                                print("Image failed to load: \(error)")
                            }
                            .fade(duration: 0.25) // Add fade transition
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                                           
                        Text(character.name)
                    }
                }
            }
            .navigationTitle("Rick and Morty Characters")
            .navigationBarTitleDisplayMode(.inline)
            .font(.footnote)
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Menu {
                                    Button(action: {
                                        // Action for Option 1
                                    }) {
                                        Label("Search Character", systemImage: "magnifyingglass")
                                    }
                                    Button(action: {
                                        // Action for Option 2
                                    }) {
                                        Label("About App", systemImage: "flame")
                                    }
                                } label: {
                                        Image(systemName: "ellipsis.circle")
                                }
                            }
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
