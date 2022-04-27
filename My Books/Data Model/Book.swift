//
//  AddBook.swift
//  My Books
//
//  Created by Матвей on 24.02.2022.
//

import Foundation




class Book: Codable {

    let title: String
    let author: String
    let genre: String
    let date: Date
    var review: String?
    
    init(title: String, author: String, genre: String, date: Date, review: String?) {
        self.title = title
        self.author = author
        self.genre = genre
        self.date = date
        self.review = review
    }
}
