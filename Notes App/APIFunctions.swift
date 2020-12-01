//
//  APIFunctions.swift
//  Notes App
//
//  This file contacts the server and retrieves data
//
//  Created by Michael Zeng on 2020-11-29.
//

import Foundation
import Alamofire

//MARK:- Custom note structure

struct Note: Decodable {

    var title: String
    var date: String
    var _id: String
    var note: String
}

//MARK:- Functions that interact with the API
class APIFunctions {

    // Sets out custom data delgate
    var delegate: DataDelegate?

    // creates an instance of the APIFunctions class
    // this lets us access the functions we write in this file, outside of this file 
    static let functions = APIFunctions()

    // fetches notes from database
    func fetchNotes() {
        // function uses fetch route to retrieve the data from the server
        AF.request("http://10.0.0.29:8081/fetch").response {
            response in
            print(response)

            // converts the response from JSON into utf8 encoding
            let data  = String(data: response.data!, encoding: .utf8)
            // tells the view controller to call updateArray function from the cusom delegate
            self.delegate?.updateArray(newArray: data!)
        }
    }
    // adds a new note from the server passing the arguments as headers
    func addNote(date: String, title:String, note: String) {

        AF.request("http://10.0.0.29:8081/create",method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON {
            response in
            print(response)

        }
    }
    // updates a new note to the server passing the arguments as headers
    func updateNote(date: String, title: String, note: String, id: String) {

        AF.request("http://10.0.0.29:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id] ).responseJSON {
            response in
            print(response)
        }
    }
    // delets a note from the server passing the notes id as a header
    func deleteNote(id: String) {

        AF.request("http://10.0.0.29:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: [ "id": id] ).responseJSON {
            response in
            print(response)
        }
    }
}
