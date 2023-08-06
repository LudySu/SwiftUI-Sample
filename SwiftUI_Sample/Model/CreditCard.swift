//
//  CreditCard.swift
//  SwiftUI_Sample
//
//  Created by Ludy Su on 5/08/23.
//

import Foundation

struct CreditCard: Hashable, Codable, Identifiable {
    let id: Int
    let uid: String
    let number: String
    let expiryDate: Date
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case number = "credit_card_number"
        case expiryDate = "credit_card_expiry_date"
        case type = "credit_card_type"
    }
}
