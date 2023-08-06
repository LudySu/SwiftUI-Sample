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

struct UICreditCard: Hashable, Identifiable {
    let id: Int
    let uid: String
    let number: String
    let expiryDate: Date
    let type: String
    
    var isSaved: Bool
    
    init(from card: CreditCard) {
        id = card.id
        uid = card.uid
        number = card.number
        expiryDate = card.expiryDate
        type = card.type
        isSaved = false
    }
    
    init(id: Int, uid: String, number: String, expiryDate: Date, type: String, isSaved: Bool) {
        self.id = id
        self.uid = uid
        self.number = number
        self.expiryDate = expiryDate
        self.type = type
        self.isSaved = isSaved
    }
}
