//
//  DessertsListViewModel.swift
//  FetchCodeChallenge
//
//  Created by Luis Roberto Blancas Lemini on 18/09/23.
//

import Foundation
import Combine

protocol DessertsListViewModelProtocol: ObservableObject {
    
    var desserts: [Dessert] { get set }
    func retrieveDesserts()
}


class DessertsListViewModel: DessertsListViewModelProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var desserts: [Dessert] = []
    @Published var errorDescription: String = ""
    
    func retrieveDesserts() {
        DessertsApiDataManager().retrieveDeserts()
            .receive(on: DispatchQueue.main)
            .sink { error in
        } receiveValue: { [weak self] fetchedDesserts in
            self?.desserts = fetchedDesserts
        }.store(in: &cancellables)
    }
    
    private func mapError(_ error : Error) {
        guard let error = error as? DessertErrors else { return }
        switch error {
        case .invalidURL:
            errorDescription = "Failed to retrieve remote data"
        }
    }
}
