//
//  TableViewController.swift
//  My Books
//
//  Created by Матвей on 16.02.2022.
//

import UIKit

class TableViewController: UITableViewController, AddBookViewControllerDelegate {
    
    
    
    var bookStore: BookStore!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        updateNavigationControllerTitle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        tableView.reloadData()
        updateNavigationControllerTitle()
    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookStore.allBooks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            
            let book = bookStore.allBooks[indexPath.row]
            
            cell.titleLabel?.text = book.title
            cell.authorLabel?.text = book.author
            cell.genreLabel?.text = String(book.genre.last!)
            
            return cell
        }
        
        return TableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movingBook = bookStore.allBooks[sourceIndexPath.item]
        bookStore.allBooks.remove(at: sourceIndexPath.item)
        bookStore.allBooks.insert(movingBook, at: destinationIndexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookStore.allBooks.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        updateNavigationControllerTitle()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = bookStore.allBooks[indexPath.row]
        self.performSegue(withIdentifier: "DetailBook", sender: book)
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook" {
           let controller = segue.destination as! AddBookViewController
           controller.delegate = self
        }
        
        if segue.identifier == "DetailBook" {
                
                if let row = tableView.indexPathForSelectedRow?.row {
                    let book = bookStore.allBooks[row]
                    let detailBookViewController
                            = segue.destination as! DetailBookViewController
                    detailBookViewController.book = book
            }
        }
    }
    
    func addBookViewController(_ controller: AddBookViewController, didFinishAdding book: Book) {
          let newRowIndex = bookStore.allBooks.count
          bookStore.allBooks.append(book)
          let indexPath = IndexPath(row: newRowIndex, section: 0)
          let indexPaths = [indexPath]
          tableView.insertRows(at: indexPaths, with: .automatic)
          navigationController?.popViewController(animated:true)
    }
    
    func updateNavigationControllerTitle() {
        if bookStore.allBooks.isEmpty {
        navigationItem.title = "Добавьте свою первую книгу👉"
            navigationItem.largeTitleDisplayMode = .never
            
        } else {
            navigationItem.title = "Мои книги"
            navigationItem.largeTitleDisplayMode = .always
        }
        
    }
    
    
    

    
}
