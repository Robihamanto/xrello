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
                        Text(boardList.name)
                    }
                    Button("+ Add Lists") {
                        
                    }
                    .padding()
                    .background(Color(.white).opacity(0.3))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                }
            }
            .padding()
            .background(Image("fuji_yama").resizable())
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(board.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
