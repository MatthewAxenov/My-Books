//
//  AddBookViewController.swift
//  My Books
//
//  Created by Матвей on 24.02.2022.
//

import UIKit

protocol AddBookViewControllerDelegate: AnyObject {
  func addBookViewController(
    _ controller: AddBookViewController,
    didFinishAdding book: Book
  )
}

class AddBookViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var genrePicker: UIPickerView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var pickedGenre: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    let genres = ["Приключения 🌋", "Классика 🎩", "Детектив 🕵️‍♀️", "Фэнтези 🧝‍♀️", "Историческая литература 🏰", "Мистика 👻", "Поэзия 🌷", "Психология 🧠", "Любовная литература 👩‍❤️‍👨", "Научная фантастика 👽", "Бизнес 💼", "Научная литература 🧪", "Детская литература 🧸", "Философия 🧐", "Современная проза 🏙", "Боевик 🔫", "Постмодернизм 🤯", "Религия 🙏"]
    
    weak var delegate: AddBookViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genrePicker.dataSource = self
        genrePicker.delegate = self
        
        addButton.layer.cornerRadius = 10

    }
    
//MARK: Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }



//MARK: IBActions


    @IBAction func addBook(_ sender: Any) {
        let book = Book(title: titleTextField.text!, author: authorTextField.text!, genre: pickedGenre.text!, date: Date(), review: nil)
        delegate?.addBookViewController(self, didFinishAdding: book)
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    
}

//MARK: Picker extensions 

extension AddBookViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
}

extension AddBookViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres.sorted()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedGenre.text = genres.sorted()[row]
    }
    
}

