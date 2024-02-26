//
//  CharacterCellView.swift
//  RickAndMortyApp
//
//  Created by Jorge Isai Garcia Reyes on 25/02/24.
//

import SwiftUI
import Kingfisher
import RickMortySwiftApi

struct CharacterCellView: View {
    let character: RMCharacterModel

    var body: some View {
        VStack {
            KFImage(URL(string: character.image))
                .placeholder {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.green, lineWidth: 2)
                )

            Text(character.name)
                .foregroundColor(.white)
                .font(.system(size: 18))
                .lineLimit(2)
                .padding(.horizontal, 8)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
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
