//
//  CreditCardRow.swift
//  SwiftUI_Sample
//
//  Created by Ludy Su on 5/08/23.
//

import SwiftUI



struct CreditCardRow: View {
    
    var card: CreditCard
    private let formatter = {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yy";
        return f;
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: UIColor(white: 0.9, alpha: 1)))
                .frame(height: 100)
            VStack(alignment: .leading) {
                Text(card.number).font(.title3)
                Spacer().frame(height: 10)
                
                HStack {
                    Text("Expiry date").font(.caption).bold()
                    Spacer()
                    Text(formatter().string(from: card.expiryDate)).font(.caption)
                
                }
                Spacer().frame(height: 5)
                HStack {
                    Text("Type").font(.caption).bold()
                    Spacer()
                    Text(card.type).font(.caption)
                }
                
                
            }.padding()
        }
    }
    
}



struct CreditCardRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CreditCardRow(card: CreditCard(id: 8717, uid: "2dd1679d-aff7-4b4d-820c-954d04062a00", number: "1234-2121-1221-1211", expiryDate: Date(timeIntervalSince1970: 1691234023), type: "mastercard"))
        
    }
    
}
