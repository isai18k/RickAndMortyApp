//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Jorge Isai Garcia Reyes on 25/02/24.
//

import SwiftUI
import Kingfisher
import RickMortySwiftApi

struct CharacterDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let character: RMCharacterModel

    var body: some View {
        CharacterDetailViewContent(character: character)
            .navigationBarTitle(character.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
    }
    
    // Custom back button
    private var backButton: some View {
        Button(action: {
            // Action when back button is tapped
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left.circle")
                    .foregroundColor(.purple) // Change the color of the back button
                    .font(.title)
                Text("Back")
                    .foregroundColor(.purple) // Change the color of the text
                    .font(.headline)
            }
        }
    }
}

struct CharacterDetailViewContent: View {
    let character: RMCharacterModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                        .foregroundColor(.purple)
                    CharacterDetailInfoView(title: "Status", value: character.status)
                    CharacterDetailInfoView(title: "Species", value: character.species)
                    CharacterDetailInfoView(title: "Type", value: character.type)
                    CharacterDetailInfoView(title: "Gender", value: character.gender)
                }
                .padding(.top, 15)
                .padding(.horizontal, 80)
                .background(.green.opacity(0.70))
                .cornerRadius(20)
                .offset(y: -35)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct CharacterDetailInfoView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title)
            Text(value)
                .font(.subheadline)
        }
        .padding(.bottom, 16)
    }
}

