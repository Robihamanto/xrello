//
//  BoardLocalRepository.swift
//  xrello
//
//  Created by Robihamanto on 2022/3/4.
//

import Foundation

struct BoardLocalRepository {
    
    static private var savePathURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first!.appendingPathComponent("board.trl")
    }
    
    static func loadBoardData() -> Board? {
        guard let data = try? Data(contentsOf: savePathURL) else { return nil }
        return try? JSONDecoder().decode(Board.self, from: data)
    }
    
    static func saveData(board: Board) {
        guard let data = try? JSONEncoder().encode(board) else { return }
        try? data.write(to: savePathURL, options: .atomic)
    }
    
}
