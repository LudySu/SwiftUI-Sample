//
//  CreditCardVM.swift
//  SwiftUI_Sample
//
//  Created by Ludy Su on 5/08/23.
//

import Foundation

class CreditCardVM: ObservableObject {
    @Published var creditCards: [CreditCard] = []
    
    func fetch() {
        guard let url = URL(string: "https://random-data-api.com/api/v2/credit_cards?size=100") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let response = try decoder.decode([CreditCard].self, from: data)
                DispatchQueue.main.async {
                    self.creditCards = response
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
