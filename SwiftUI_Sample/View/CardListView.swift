//
//  ContentView.swift
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

    var body: some View {
        NavigationView {
            List(viewModel.creditCards) { card in
                CreditCardRow(card: card)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.none)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Card List")
        }
    }
}
