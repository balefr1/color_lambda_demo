var express = require('express');
const serverless = require('serverless-http')
const cors = require('cors');
const path = require('path');


var app = express();


app.use(cors({
    origin: '*'
}));

var rqs = 0;
var fakeErr = false;
var colorChg = false;
var color = "orange";
var symbol = "◉";

app.get("/",function (req, res) {
    res.sendFile(path.join(__dirname+'/index.html'), {maxAge: 600*1000});
})

app.get('/color', function (req, res) {
    rqs++
    //console.log(".")

    randomN = Math.floor(Math.random() * 9) + 1
    if (fakeErr && randomN > 8){
        console.log('fake err')
        res.statusCode = 500
        res.json({"error":true})
        return
    }

    if (colorChg && randomN > 7){
        res.json({"color":"orange","symbol":"▩","random_number":randomN})
        return
    } 
    res.json({"color":color,"symbol":symbol,"random_number":randomN})
})

//  var server = app.listen(8081,function(){
//      console.log("server up")
//  })

module.exports.handler = serverless(app);
