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
    @State private var groupByType = false
    
    var filteredList: [UICreditCard] {
        viewModel.creditCards.filter { card in
            (!showSavedOnly || card.isSaved)
        }
    }
    
    var cardMap: [String : [UICreditCard]] {
        return filteredList.reduce(into: [String : [UICreditCard]]()) { result, card in
            var list = result[card.type] ?? [UICreditCard]()
            list.append(card)
            result[card.type] = list
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showSavedOnly) {
                    Text("Saved only")
                }
                Toggle(isOn: $groupByType) {
                    Text("Group by type")
                }
                
                if (groupByType) {
                    ForEach(Array(cardMap.keys).sorted(by: <), id: \.self) { type in
                        Section {
                            ForEach(cardMap[type]!) { card in
                                CreditCardRow(card: card)
                                    .environmentObject(viewModel)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(.none)
                            }
                        } header: {
                            Text(type)
                        }
                    }
                } else {
                    ForEach(filteredList) { card in
                        CreditCardRow(card: card)
                            .environmentObject(viewModel)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.none)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Card List")
            .refreshable {
                viewModel.fetch()
            }
            .alert("Error", isPresented: .constant(viewModel.isError)) {
                Button("OK") { }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error, please retry later")
            }
            .overlay {
                if (viewModel.isLoading && !viewModel.isError) {
                    ProgressView("Fetching data, please wait...")
                              .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }
            }
        }
    }
}
