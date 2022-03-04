//
//  BoardView.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/21.
//

import SwiftUI

let boardListBackgroundColor = Color(uiColor: UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1))


struct BoardView: View {
    
    @StateObject private var board = Board.stub
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 24) {
                    ForEach(board.lists) { boardList in
                        BoardListView(board: board, boardList: boardList)
                    }
                    Button("+ Add Lists") {
                        addNewBoardList()
                    }
                    .padding()
                    .background(Color(.white).opacity(0.3))
                    .frame(height: 30)
                    .cornerRadius(8)
                    .foregroundColor(.black)
                }
                .padding()
                .animation(.default, value: board.lists)
            }
            .background(
                Image("fuji_yama")
                    .resizable()
                    .aspectRatio(.none, contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(board.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
    
    private func addNewBoardList() {
        presentAlertTextField(title: "Add list") { text in
            guard let name = text, !name.isEmpty else { return }
            board.addNewBoardListWithName(name)
        }
    }
    
    
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
