//
//  ViewController.swift
//  Notes App
//
//  Created by Michael Zeng on 2020-11-27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK:- Initializations

    @IBOutlet weak var notesTableView: UITableView!
    // this is an array of Note objects
    var notesArray = [Note]()


    // MARK:- Seque Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vc = segue.destination as! AddNoteViewController

        // passes the note and tells the view controller to update an existing note instead of adding a new one
        if segue.identifier == "updateNoteSegue" {
            // passes the note object to the AddNoteViewController
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true 
        }
    }

    // MARK:- LifeCycle Hooks

    override func viewWillAppear(_ animated: Bool) {
        // updates note array
        APIFunctions.functions.fetchNotes()
    }

    override func viewDidAppear(_ animated: Bool) {
        // updates note array
        APIFunctions.functions.fetchNotes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notesTableView.delegate = self
        notesTableView.dataSource = self

        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()

    }
    // MARK:- Table View Delegates

    // this function creates one row for each element in the array
    // This delegate function asks "How many rows do you want to display?"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }

    // in the table view we have cells, each on is labeled "prototypeCell"
    // This delegate function asks "What do you want to display in each row?"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell

        // sets the title, note body and date into the table view
        cell.titleLabel.text = notesArray[indexPath.row].title
        cell.noteLabel.text = notesArray[indexPath.row].note
        cell.dateLabel.text = notesArray[indexPath.row].date

        return cell
    }
}

// MARK:- Custom Delegates

protocol DataDelegate {
    func updateArray(newArray: String)
}

// this is still part of the view controller class 
extension ViewController: DataDelegate {

    func updateArray(newArray: String) {
        // error catching
        do {
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(notesArray)

        }catch{
            print("Failed to decode!")
        }
        // updates table view each time we get new notes 
        self.notesTableView.reloadData()
    }
}

