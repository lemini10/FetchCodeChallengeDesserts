//
//  DessertsApiDataManager.swift
//  FetchCodeChallenge
//
//  Created by Luis Roberto Blancas Lemini on 18/09/23.
//

import Foundation
import Combine

protocol DessertsApiDataManagerProtocol {
    func retrieveDeserts() -> AnyPublisher<Dessert, Error>
}

class DessertsApiDataManager {
    func retrieveDeserts() -> AnyPublisher<[Dessert], Error> {
        guard let url: URL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return Fail(error: DessertErrors.invalidURL).eraseToAnyPublisher() }
        let urlRequest: URLRequest = URLRequest(url: url)
        let task =  URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: DessertsDTO.self , decoder: JSONDecoder())
            .map{ $0.meals }
            .eraseToAnyPublisher()
        return task
    }
}


struct DessertsDTO: Codable {
    let meals: [Dessert]
}


struct Dessert: Codable, Identifiable {
    var id = UUID()
    let name: String
    let identifier: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case identifier = "idMeal"
        case image = "strMealThumb"
    }
}


enum DessertErrors: Error {
    case invalidURL
}
