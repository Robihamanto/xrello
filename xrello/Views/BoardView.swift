//
//  BoardView.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/21.
//

import SwiftUI

let boardListBackgroundColor = Color(uiColor: UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1))


struct BoardView: View {
    
    @StateObject private var board = BoardLocalRepository.loadBoardData() ?? Board.stub
    @State private var dragging: BoardList?
    @State private var urlImage = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 24) {
                    ForEach(board.lists) { boardList in
                        BoardListView(board: board, boardList: boardList)
                            .onDrag({
                                self.dragging = boardList
                                return NSItemProvider(object: boardList)
                            })
                            .onDrop(of: [Card.typeIdentifier, BoardList.typeIdentifier], delegate: BoardDropDelegate(board: board, boardList: boardList, lists: $board.lists, current: $dragging))
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
                ZStack {
                    Image("fuji_yama")
                        .resizable()
                        .aspectRatio(.none, contentMode: .fill)
                    
                    AsyncImage(
                        url: URL(string: urlImage)) { image in
                            image
                                .resizable()
                        } placeholder: {
                        EmptyView()
                        }
                    
                }
            )
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(board.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button() { renameBoard() } label: {
                    Label("Rename", systemImage: "pencil.circle")
                }
            }
        }
        .navigationViewStyle(.stack)
        .safeAreaInset(edge: .bottom, alignment: .trailing, content: {
            Button {
                generateRandomBackgroundImage()
            } label: {
                Label("Random Background", systemImage: "wand.and.stars")
            }
            .padding()
            .background(Color(.white).opacity(0.75))
            .foregroundColor(.black)
            .frame(height: 50)
            .cornerRadius(8)
            .offset(x: -8, y: 0)
            
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            BoardLocalRepository.saveData(board: board)
        }
    }
    
    private func addNewBoardList() {
        presentAlertTextField(title: "Add list") { text in
            guard let name = text, !name.isEmpty else { return }
            board.addNewBoardListWithName(name)
        }
    }
    
    private func renameBoard() {
        presentAlertTextField(title: "Rename Board", defaultTextFieldText: board.name) { text in
            guard let name = text, !name.isEmpty else { return }
            board.name = name
        }
    }
    
    private func generateRandomBackgroundImage() {
        presentAlertTextField(title: "Generate Background", message: "Input any words to get random image from Unsplash", defaultTextFieldText: "tokyo") { text in
            guard
                let query = text,
                !query.isEmpty
            else { return }
            urlImage = "https://source.unsplash.com/random/?" + query
        }
    }
    
    
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
