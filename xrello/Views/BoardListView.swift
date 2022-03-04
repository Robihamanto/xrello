//
//  BoardListView.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/27.
//

import SwiftUI
import Introspect

struct BoardListView: View {
    
    @ObservedObject var board: Board
    @StateObject var boardList: BoardList
    
    @State var listHeight: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView
            listView
                .listStyle(.plain)
                .frame(maxHeight: listHeight)
            
            Button("+ Add Card") { addCardItem() }
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
            Text(boardList.name)
                .font(.headline)
                .lineLimit(2)
            Spacer()
            Menu {
                Button("Edit") {
                    editBoardListName()
                }
                Button("Delete", role: .destructive) {
                    removeBoardList()
                }
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
                CardItemView(boardList: boardList, card: card)
                    .onDrag{ NSItemProvider(object: card) }
            }
            .onInsert(of: [Card.typeIdentifier], perform: onInsertCard(index:itemProviders:))
            .onMove(perform: boardList.moveCard(fromOffsets:toOffset:))
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
            .listRowBackground(Color.clear)
            .introspectTableView {
                listHeight = $0.contentSize.height
            }
        }
    }
    
    private func onInsertCard(index: Int, itemProviders: [NSItemProvider]) {
        for itemProvider in itemProviders {
            itemProvider.loadObject(ofClass: Card.self) { item, _ in
                guard let card = item as? Card else { return }
                DispatchQueue.main.async {
                    board.move(card: card, to: boardList, at: index)
                }
            }
        }
    }
    
    private func editBoardListName() {
        presentAlertTextField(title: "Edit board name", defaultTextFieldText: boardList.name) { text in
            guard let text = text, !text.isEmpty else { return }
            boardList.name = text
        }
    }
    
    private func removeBoardList() {
        board.removeBoardList(self.boardList)
    }
    
    private func addCardItem() {
        presentAlertTextField(title: "Add new item to \(boardList.name)") { text in
            guard let text = text, !text.isEmpty else { return }
            boardList.addNewCard(with: text)
        }
    }
    
}

struct BoardListView_Previews: PreviewProvider {
    
    @StateObject static var board = Board.stub
    
    static var previews: some View {
        BoardListView(board: board, boardList: board.lists.first!, listHeight: 512)
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 512)
    }
}
