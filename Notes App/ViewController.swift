//
//  ViewController.swift
//  Notes App
//
//  Created by Michael Zeng on 2020-11-27.
//

import UIKit

protocol DataDelegate {
    func updateArray(newArray: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // this is an array of Note objects
    var notesArray = [Note]()

    // this function creates one row for each element in the array
    // This delegate function asks "How many rows do you want to display?"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count 
    }

    // in the table view we have cells, each on is labeled "prototypeCell"
    // This delegate function asks "What do you want to display in each row?"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row].title
        return cell
    }

    @IBOutlet weak var notesTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notesTableView.delegate = self
        notesTableView.dataSource = self

        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()

    }
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

