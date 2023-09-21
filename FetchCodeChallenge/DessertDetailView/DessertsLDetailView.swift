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
    
    let minimumRowHeight: CGFloat = 50
    
    
    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        
        let errorView: some View = ZStack {
            VStack(spacing: 25) {
                Image(systemName: "questionmark.diamond.fill")
                    .font(.system(size: 60))
                Text("Something went wrong")
                    .font(.largeTitle)
            }
        }
        let recipeFound: some View = ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.name)
                        .font(.largeTitle)
                    Text("Instrucctions")
                        .font(.title)
                    Text(viewModel.instruccions)
                    Text("Ingredients")
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
                    .frame(height: minimumRowHeight * CGFloat(viewModel.ingredients.count))
                }.padding()
            }.alert(isPresented: $viewModel.showAlertError) {
                Alert(title: Text("Something went wrong"), message: Text("The information you requested is not available"), dismissButton: .default(Text("OK"), action: {
                    self.presentationMode.wrappedValue.dismiss()
                }))
                
            }
        }.onAppear {
            viewModel.retrieveDesserts()
        }
        return recipeFound
    }
}
