var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var methodOverride = require('method-override');
var session = require('express-session');
var bodyParser = require('body-parser');
var multer = require('multer');
var errorHandler = require('errorhandler');

var app = express()

app.set('port', 3001)
app.set('views', path.join(__dirname, 'jade'))
app.set('view engine', 'jade')
app.use(favicon(path.join(__dirname, 'static/favicon.ico')))
app.use(methodOverride())
app.use(session({
    resave: true,
    saveUninitialized: true,
    secret: 'uwotm8'
}))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }));
// app.use(multer());
app.use(express.static(path.join(__dirname, 'static')));

// development only
if ('development' == app.get('env')) {
    app.use(errorHandler());
}

app.get('/index.html', function(req, res) {
    res.render("index")
})

app.get("/index2.html", function(req, res){
    res.send("Hello index2");
    res.end();
});

app.get('/', function(req, res) {
    console.log('index.html')
    // res.send('index')
    res.send({data: [{
        id: 'a',
        name: 'jack'
    }]})
    res.end()
})
app.get('/main.html', function(req, res ) {
    console.log('main.html')
    res.render('main')
})
                    
app.listen(app.get('port'), function(){
    console.log('Express server listening on port ' + app.get('port'));
});
