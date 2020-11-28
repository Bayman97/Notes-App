// schema = object that holds our data 

var mongoose = require("mongoose")
var Schema = mongoose.Schema

var note = new Schema({

    title: String,
    date: String,
    note: String

})

// creates data object that is a note schema 
const Data = mongoose.model("Data", note)

// allows us to access teh schema from the server.js file 
module.exports = Data