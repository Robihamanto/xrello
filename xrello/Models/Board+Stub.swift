//
//  Board+Stub.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/21.
//

import Foundation

extension Board {
    
    static var stub: Board {
        let board = Board(name: "Japanese Prefecture ๐ฏ๐ต")
        let prefectureBoardList = BoardList(name: "Prefecture / ็", boardID: board.id)
        let prefectureCard = [
            "Tokyo",
            "Kanagawa",
            "Osaka",
            "Aichi",
            "Hokkaido",
            "Fukuoka",
        ].map{ Card(content: $0, boardList: prefectureBoardList.id) }
        prefectureBoardList.cards = prefectureCard
        
        
        let visitedPrefectureBoardList = BoardList(name: "Visited / ่จชๅใใ", boardID: board.id)
        let visitedPrefectureCard = [
            "Kanagawa",
            "Hyogo",
            "Kyoto",
            "Saitama",
        ].map{ Card(content: $0, boardList: visitedPrefectureBoardList.id) }
        visitedPrefectureBoardList.cards = visitedPrefectureCard
        
        let otherPrefectureBoardList = BoardList(name: "Other Prefecture / ใใฎไป็", boardID: board.id)
        let otherPrefectureCard = [
            "Kanagawa",
            "Hyogo",
        ].map{ Card(content: $0, boardList: otherPrefectureBoardList.id) }
        otherPrefectureBoardList.cards = otherPrefectureCard
        
        board.lists = [
        prefectureBoardList,
        visitedPrefectureBoardList,
        otherPrefectureBoardList
        ]
        
        return board
    }
    
}
