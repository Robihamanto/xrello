//
//  BoardListView.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/27.
//

import SwiftUI

struct BoardListView: View {
    
    @ObservedObject var board: Board
    @StateObject var boardList: BoardList
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView
            listView
                .listStyle(.plain)
            
            Button("+ Add Card") {}
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical)
        .cornerRadius(8)
        .frame(width: 300)
        .background(boardListBackgroundColor)
        .foregroundColor(.black)
    }
    
    private var headerView: some View {
        HStack {
            Text(board.name)
                .font(.headline)
                .lineLimit(2)
            Spacer()
            Menu {
                Button("Rename") {}
                Button("Delete", role: .destructive) {}
            } label: {
                Image(systemName: "ellipsis.circle")
                    .imageScale(.large)
            }
        }
        .padding(.horizontal)
    }
    
    private var listView: some View {
        List {
            ForEach(boardList.cards) { card in
                CardItemView()
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 8, leading: 4, bottom: 4, trailing: 8))
            .listRowBackground(Color.clear)
        }
    }
    
    
}

struct BoardListView_Previews: PreviewProvider {
    
    @StateObject static var board = Board.stub
    
    static var previews: some View {
        BoardListView(board: board, boardList: board.lists.first!)
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 512)
    }
}
