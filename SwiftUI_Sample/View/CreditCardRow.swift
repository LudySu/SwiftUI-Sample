//
//  CreditCardRow.swift
//  SwiftUI_Sample
//
//  Created by Ludy Su on 5/08/23.
//

import SwiftUI



struct CreditCardRow: View {
    
    @EnvironmentObject var viewModel: CreditCardVM
    var card: UICreditCard
    
    private let formatter = {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yy";
        return f;
    }
    
    var cardIndex: Int {
        viewModel.creditCards.firstIndex(where: { $0.id == card.id }) ?? 0
     }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: UIColor(white: 0.9, alpha: 1)))
                .frame(height: 100)
            VStack(alignment: .leading) {
                HStack {
                    Text(card.number).font(.title3)
                    Spacer()
                    FavoriteButton(isSet: $viewModel.creditCards[cardIndex].isSaved)
                }
                
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

struct FavoriteButton: View {

    @Binding var isSet: Bool

    var body: some View {

        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(.yellow)
        }
    }

}



struct CreditCardRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let card = UICreditCard(id: 8717, uid: "2dd1679d-aff7-4b4d-820c-954d04062a00", number: "1234-2121-1221-1211", expiryDate: Date(timeIntervalSince1970: 1691234023), type: "mastercard", isSaved: false)
        CreditCardRow(card: card)
    }
    
}
