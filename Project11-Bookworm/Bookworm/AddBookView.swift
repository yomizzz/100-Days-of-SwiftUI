//
//  AddBookView.swift
//  Bookworm
//
//  Created by yomizzz on 2022/4/4.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc // 在哪里使用数据就在哪里声明
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["经济理财", "个人成长", "小说", "文学", "历史", "心理", "哲学宗教", "人物传记", "社会文化", "生活百科", "教育学习", "医学健康", "计算机", "科学科技", "政治军事", "艺术", "童书", "期刊专栏", "原版书"] // 参考微信读书书籍分类
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        // 将数据保存在数据库中
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? moc.save()
                        
                        dismiss() // 完成后自动关闭添加书籍页面
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
