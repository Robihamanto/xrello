//
//  Board.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/21.
//

import Foundation

class Board: NSObject, ObservableObject, Identifiable, Codable {
    
    private(set) var id = UUID()

    @Published var name: String
    @Published var lists: [BoardList]
    
    enum CodingKeys: String, CodingKey {
        case id, name, lists
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.lists = try container.decode([BoardList].self, forKey: .lists)
        super.init()
    }
    
    init(name: String, lists: [BoardList] = []) {
        self.name = name
        self.lists = lists
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(lists, forKey: .lists)
    }
    
    func move(card: Card, to boardList: BoardList, at index: Int) {
        guard
            let sourceBoardListIndex = boardListIndex(id: card.boardListID),
            let destinationBoardListIndex = boardListIndex(id: boardList.id),
            sourceBoardListIndex != destinationBoardListIndex
        else { return }
        
        card.boardListID = boardList.id
        boardList.cards.insert(card, at: index)
        lists[sourceBoardListIndex].removeCard(with: card.id)
    }
    
    private func cardIndexInBoardList(id: UUID, boardListIndex: Int) -> Int? {
        lists[boardListIndex].cardIndex(id: id)
    }
    
    private func boardListIndex(id: UUID) -> Int? {
        lists.firstIndex { $0.id == id }
    }
    
}
