//
//  BookStore.swift
//  My Books
//
//  Created by Матвей on 03.03.2022.
//

import UIKit

class BookStore {
    var allBooks = [Book]()
    
    
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("books.plist")
    }()
    
    @objc func saveChanges() -> Bool {
        print("Saving books to: \(itemArchiveURL)")
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allBooks)
            try data.write(to: itemArchiveURL, options: [.atomic])
            print("Saved all of the books")
            return true
    } catch let encodingError {
            print("Error encoding allBooks: \(encodingError)")
        return false
        }
    }
    
    init() {
        do {
                let data = try Data(contentsOf: itemArchiveURL)
                let unarchiver = PropertyListDecoder()
                let books = try unarchiver.decode([Book].self, from: data)
                allBooks = books
        } catch {
                print("Error reading in saved books: \(error)")
            }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
    }

    
}
