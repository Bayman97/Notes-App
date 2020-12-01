//
//  AddNoteViewController.swift
//  Notes App
//
//  Created by Michael Zeng on 2020-11-29.
//

import UIKit

class AddNoteViewController: UIViewController {

    //MARK:- Initialization

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    var note: Note?
    var update = false 

    // MARK:- UI Buttons

    @IBAction func saveClick(_ sender: Any) {

        // creates a string date to pass into the note
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())

        // if the user is updating instead of saving
        if update ==  true {
            APIFunctions.functions.updateNote(date: date, title: titleTextField.text!, note: bodyTextView.text, id: note!._id)
            self.navigationController?.popViewController(animated: true)
        }
        // can only save if title and body are both not empty
        else if titleTextField.text != "" && bodyTextView.text != ""{
            APIFunctions.functions.addNote(date: date, title: titleTextField.text!, note: bodyTextView.text)
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func deleteClick(_ sender: Any) {
        APIFunctions.functions.deleteNote(id: note!._id)

        // returns back to main screen after note is deleted
        self.navigationController?.popViewController(animated: true)
    }

    // MARK:- LifeCycle Hooks

    override func viewWillAppear(_ animated: Bool) {
        // disables the delete button if the user is adding a new note
        if update == false {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // prepopulates the text field if the user is updating the note
        if update ==  true {
            titleTextField.text = note!.title
            bodyTextView.text = note!.note
        }
    }
}
