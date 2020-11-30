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

// define a note object
struct Note: Decodable {

    var title: String
    var date: String
    var _id: String
    var note: String
}

class APIFunctions {

    var delegate: DataDelegate?

    // creates an instance of the APIFunctions class
    // this lets us access the functions we write in this file, outside of this file 
    static let functions = APIFunctions()

    func fetchNotes() {

        // function uses fetch route to retrieve the data from the server
        AF.request("http://10.0.0.29:8081/fetch").response {
            response in
            print(response.data!)

            // encodes the data with utf8 encoding for easy parsing
            let data  = String(data: response.data!, encoding: .utf8)

            // call delegate
            // tells the view controller to call updateArray function 
            self.delegate?.updateArray(newArray: data!)
        }
    }


    func addNote(date: String, title:String, note: String) {

        AF.request("http://10.0.0.29:8081/create",method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON {
            response in
            print(response)

        }
    }

    func updateNote(date: String, title: String, note: String, id: String) {

        AF.request("http://10.0.0.29:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id] ).responseJSON {
            response in
            print(response)
        }
    }

    func deleteNote(id: String) {

        AF.request("http://10.0.0.29:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: [ "id": id] ).responseJSON {
            response in
            print(response)
        }
    }
}
