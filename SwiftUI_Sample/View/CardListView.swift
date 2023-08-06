//
//  CardListView.swift
//  SwiftUI_Sample
//
//  Created by Ludy Su on 5/08/23.
//

import SwiftUI

struct CardListView: View {
    @StateObject var viewModel = CreditCardVM()

    var body: some View {
        _CardListView(viewModel: viewModel)
            .onAppear {
                viewModel.fetch()
            }
    }
}

private struct _CardListView: View {
    @ObservedObject var viewModel: CreditCardVM
    @State private var showSavedOnly = false
    
    var filteredList: [UICreditCard] {
        viewModel.creditCards.filter { card in
            (!showSavedOnly || card.isSaved)
        }
    }

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showSavedOnly) {
                    Text("Saved only")
                }
                
                ForEach(filteredList) { card in
                    CreditCardRow(card: card)
                        .environmentObject(viewModel)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.none)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Card List")
        }
    }
}
