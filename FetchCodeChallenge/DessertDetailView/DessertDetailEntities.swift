//
//  Entities.swift
//  FetchCodeChallenge
//
//  Created by Luis Roberto Blancas Lemini on 24/09/23.
//

import Foundation

struct Ingredient: Identifiable {
    let id: UUID = UUID()
    let ingredient: String
    let quantity: String
}
