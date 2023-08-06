//
//  CreditCardVM.swift
//  SwiftUI_Sample
//
//  Created by Ludy Su on 5/08/23.
//

import Foundation

class CreditCardVM: ObservableObject {
    @Published var creditCards: [UICreditCard] = []
    @Published var isError = false
    @Published var errorMessage: String?
    
    func fetch() {
        guard let url = URL(string: "https://random-data-api.com/api/v2/credit_cards?size=100") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                self.isError = true
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                self.isError = true
                self.errorMessage = "No data found, please try again later"
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let response = try decoder.decode([CreditCard].self, from: data)
                DispatchQueue.main.async {
                    self.creditCards = response.map { UICreditCard(from: $0) }
                    self.isError = false
                    self.errorMessage = nil
                }
            } catch {
                self.isError = true
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
            }
        }.resume()
    }
}
