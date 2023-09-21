//
//  ContentView.swift
//  FetchCodeChallenge
//
//  Created by Luis Roberto Blancas Lemini on 17/09/23.
//

import SwiftUI

struct ContentView<ViewModel: DessertsListViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.desserts) { dessert in
                    NavigationLink {
                        DessertsDetailView(viewModel: DessertsDetailViewModel(mealId: dessert.identifier))
                    } label: {
                        DessertRow(dessert: dessert)
                    }.navigationTitle("Desserts")
                }
                .onAppear {
                    viewModel.retrieveDesserts()
            }
        }
    }
}

struct DessertRow: View {
    var dessert: Dessert
    
    var body: some View {
        Text(dessert.name)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: DessertsListViewModel())
    }
}
