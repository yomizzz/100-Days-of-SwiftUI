//
//  DetailView.swift
//  Bookworm
//
//  Created by yomizzz on 2022/4/5.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    func deleteBook() {
        moc.delete(book)
        
        // try? moc.save()
        dismiss()
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "个人成长")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre ?? "个人成长")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "个人成长"
        book.rating = Int16(4)
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
