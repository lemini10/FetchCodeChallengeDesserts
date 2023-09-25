//
//  DessertsDetailViewModel.swift
//  FetchCodeChallenge
//
//  Created by Luis Roberto Blancas Lemini on 20/09/23.
//

import Foundation
import Combine

protocol DessertsDetailViewModelProtocol: ObservableObject {
    
    var name: String { get set }
    var instruccions: String { get set }
    var ingredients: [Ingredient] { get set }
    
    var showAlertError: Bool { get set }
    
    func retrieveDesserts()
}


class DessertsDetailViewModel: DessertsDetailViewModelProtocol {
    
    let mealId: String
    
    @Published var name: String = String()
    @Published var instruccions: String = String()
    @Published var ingredients: [Ingredient] = []
    @Published var showAlertError: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(mealId: String) {
        self.mealId = mealId
    }
    
    func retrieveDesserts() {
        DessertsDetailApiDataManager().retrieveDesertDetails(for: mealId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.showAlertError = true
                }
            } receiveValue: { [weak self] fetchedDessert in
                self?.name = fetchedDessert.name
                self?.instruccions = fetchedDessert.instructions
                guard let allProperties = fetchedDessert.allProperties else { return }
                var requiredIngredients: [Ingredient] = []
                for propertie in allProperties {
                    guard propertie.key.contains(DessertDetailConstants.DecodableConstants.ingredientsKey) && !propertie.value.isEmpty else { continue }
                    let ingredientIndex: String = propertie.key.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    guard let quantity: String = allProperties[DessertDetailConstants.DecodableConstants.measureKey + ingredientIndex] else { continue }
                    let ingredient: Ingredient = Ingredient(ingredient: propertie.value, quantity: quantity)
                    requiredIngredients.append(ingredient)
                }
                self?.ingredients = requiredIngredients
                
            }.store(in: &cancellables)
    }
}

extension Encodable {
    var allProperties: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: String] }
    }
}
