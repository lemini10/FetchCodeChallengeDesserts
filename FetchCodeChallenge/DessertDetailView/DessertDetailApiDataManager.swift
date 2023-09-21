//
//  DessertDetailApiDataManager.swift
//  FetchCodeChallenge
//
//  Created by Luis Roberto Blancas Lemini on 20/09/23.
//

import Foundation
import Combine

protocol DessertsDetailApiDataManagerProtocol {
    func retrieveDesertDetails(for id: String) -> AnyPublisher<DessertDetails, Error>
}

class DessertsDetailApiDataManager: DessertsDetailApiDataManagerProtocol {
    func retrieveDesertDetails(for id: String) -> AnyPublisher<DessertDetails, Error> {
        guard let url: URL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return Fail(error: DessertErrors.invalidURL).eraseToAnyPublisher() }
        let urlRequest: URLRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: DessertsDetailsDTO.self, decoder: JSONDecoder())
            .compactMap{$0.meals.first}
            .eraseToAnyPublisher()
        return task
    }
}

struct DessertsDetailsDTO: Codable {
    let meals: [DessertDetails]
}


struct DessertDetails: Codable {
    
    let name: String
    let instructions: String
    
    let ingredient1: String
    let ingredient2: String
    let ingredient3: String
    let ingredient4: String
    let ingredient5: String
    let ingredient6: String
    let ingredient7: String
    let ingredient8: String
    let ingredient9: String
    let ingredient10: String
    let ingredient11: String
    let ingredient12: String
    let ingredient13: String
    let ingredient14: String
    let ingredient15: String
    let ingredient16: String
    let ingredient17: String
    let ingredient18: String
    let ingredient19: String
    let ingredient20: String

    let quantity1: String
    let quantity2: String
    let quantity3: String
    let quantity4: String
    let quantity5: String
    let quantity6: String
    let quantity7: String
    let quantity8: String
    let quantity9: String
    let quantity10: String
    let quantity11: String
    let quantity12: String
    let quantity13: String
    let quantity14: String
    let quantity15: String
    let quantity16: String
    let quantity17: String
    let quantity18: String
    let quantity19: String
    let quantity20: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        
        case quantity1 = "strMeasure1"
        case quantity2 = "strMeasure2"
        case quantity3 = "strMeasure3"
        case quantity4 = "strMeasure4"
        case quantity5 = "strMeasure5"
        case quantity6 = "strMeasure6"
        case quantity7 = "strMeasure7"
        case quantity8 = "strMeasure8"
        case quantity9 = "strMeasure9"
        case quantity10 = "strMeasure10"
        case quantity11 = "strMeasure11"
        case quantity12 = "strMeasure12"
        case quantity13 = "strMeasure13"
        case quantity14 = "strMeasure14"
        case quantity15 = "strMeasure15"
        case quantity16 = "strMeasure16"
        case quantity17 = "strMeasure17"
        case quantity18 = "strMeasure18"
        case quantity19 = "strMeasure19"
        case quantity20 = "strMeasure20"
    }
}
