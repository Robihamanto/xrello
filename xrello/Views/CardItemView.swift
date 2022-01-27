//
//  CardItemView.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/27.
//

import SwiftUI

struct CardItemView: View {
    
    @ObservedObject var boardList: BoardList
    @StateObject var card: Card
    
    var body: some View {
        HStack {
            Text(card.content)
            Spacer()
            Menu {
                Button("Rename") {}
                Button("Delete", role: .destructive) {}
            } label: {
                Image(systemName: "ellipsis.rectangle")
                    .imageScale(.small)
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(4)
        .shadow(radius: 1, y: 1)
    }
}


struct CardItemView_Previews: PreviewProvider {
    
    @StateObject static var boardList = Board.stub.lists.first!
    
    static var previews: some View {
        CardItemView(boardList: boardList, card: boardList.cards.first!)
            .previewLayout(.sizeThatFits)
            .frame(width: 300)
    }
}
