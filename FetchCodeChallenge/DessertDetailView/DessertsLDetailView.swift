//
//  DessertsListView.swift
//  FetchCodeChallenge
//
//  Created by Luis Roberto Blancas Lemini on 18/09/23.
//

import Foundation
import SwiftUI
import Combine


struct DessertsDetailView<ViewModel: DessertsDetailViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        let recipeFound: some View = ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    titleView
                    ingredientsView
                    instrucctionsView
                }.padding()
            }.alert(isPresented: $viewModel.showAlertError) {
                alertView
            }
        }.onAppear {
            viewModel.retrieveDesserts()
        }
        return recipeFound
    }
    
    private var ingredientsView: some View {
        VStack(alignment: .leading) {
            Text(DessertDetailConstants.Localizables.ingredientsTitle)
                .font(.title)
            List(viewModel.ingredients) { ingredient in
                HStack {
                    Text(ingredient.ingredient)
                    Spacer()
                    Text(ingredient.quantity)
                }
            }
            .disabled(true)
            .border(.gray)
            .frame(height: DessertDetailConstants.Constants.minimumRowHeight * CGFloat(viewModel.ingredients.count))
        }
    }
    
    private var alertView: Alert {
        Alert(title: Text(DessertDetailConstants.Localizables.alertHeader),
              message: Text(DessertDetailConstants.Localizables.alertDetails),
              dismissButton: .default(Text(DessertDetailConstants.Localizables.alertDismissButton), action: {
            self.presentationMode.wrappedValue.dismiss()
        }))
    }
    
    private var instrucctionsView: some View {
        VStack(alignment: .leading) {
            Text(DessertDetailConstants.Localizables.instrucctionsTitle)
                .font(.title)
            Text(viewModel.instruccions)
        }
    }
    
    private var titleView: some View {
        Text(viewModel.name)
            .font(.largeTitle)
    }
}
