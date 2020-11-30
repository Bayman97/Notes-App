// npm init, note package manager keeps track of the dependencies we use and which versions 



const express = require('express')
const mongoose = require('mongoose')

var app = express() 
var Data = require('./noteSchema')

// we want mongoose to connect to MongoDB
// MongoDB runs on our machine (localhost) and go to the folder newDB 
// all our data will be stored in new DB 
mongoose.connect('mongodb://localhost/newDB', {
     useNewUrlParser: true, 
     useUnifiedTopology: true 
    })



mongoose.set('useFindAndModify', false);
// once the connection is open, function will print
// otherwise it will print the error  
mongoose.connection.once("open", function() {

    console.log("Connected to database")

}).on("error", function(error){

    console.log("Failed to connect " + error)

})

// CREATE A NOTE
// POST request 
app.post("/create", function(req, res) {

    // this creates a note object that holds the data the IPhone sends here to the server 
    var note = new Data ({

        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date"),

    })

    note.save().then(function() {

        // if the note is stored on both server and data base then isNew == false meaning it is saved to database 
        // otherwise isNew == true then the data is only on the server and not saved to database 
        if (note.isNew == false) {
            console.log("Saved data!")
            // tell IPhone data is saved 
            res.send("Saved data!")

        }
        else {
            console.log("Failed to save data")
        }
    })
})

// FETCH ALL NOTES 
// GET request 
app.get('/fetch', function(req, res){

    // find({}) notation means get everything 
    Data.find({}).then( function(DBitems) {

        res.send(DBitems)
    })
})

// DELETE A NOTE
// POST request  
app.post("/delete", function(req, res){
    Data.findOneAndRemove({
        _id: req.get("id")

    }, function(err) {
        // only happens if fails to get id 
        console.log("Failed " + err)
    })
    res.send("Deleted")
})

// UPDATE A NOTE 
// POST request 
app.post("/update", function(req, res) {
    // id is the first {}
    // new data is second {}
    Data.findOneAndUpdate({
        _id: req.get("id")
    },{
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date"),

    }, function(err) {
        console.log("Failed to update " + err)
    })
    res.send("Updated!")

})


// http://10.0.0.29:8081/create
var server = app.listen(8081, "10.0.0.29", function() {

    console.log("Server is running!")
})