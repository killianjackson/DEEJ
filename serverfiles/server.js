var mysql = require('mysql');
var restify = require('restify');
var sanitizer = require('sanitizer');
var connection = mysql.createConnection({
  host  : 'localhost',
  user  : 'root',
  password  : 'root',
  database  : 'deej',
  port  : 3306
});

function test1(req, res, next) {
  console.log(req.params.amount);
  res.send("Hello 1");
  next();
}

////////////////////////////////////////////////////////
// Users
////////////////////////////////////////////////////////

//Insert user into users table
function updateUser(req,res,next){
	var query = "INSERT INTO users (clientID, status) VALUES(" + 
				mysql.escape(req.body.clientID) + "," +
				//mysql.escape(req.body.fullname) + "," +
				mysql.escape(req.body.status) + ") " +
				"ON DUPLICATE KEY UPDATE " + 
				"clientID=" + mysql.escape(req.body.clientID) + "," + 
				//"fullname=" + mysql.escape(req.body.fullname) + "," + 
				"status=" + mysql.escape(req.body.status) + ";";
	connection.query(query, function(err, results) {
      if(err) res.send(400);
      res.send(200);
      next();
  });
}

//Get List of All Users
function getUsers(req,res,next){
	var query = "SELECT * FROM users";
  	connection.query(query, function(err,rows) {
    	if (err) throw err;
    	res.send(rows);
    	next();
    }
  );
}

//Get List of Currently Active Users and Playing Songs
function getActiveUsers(req,res,next){
	var query = "SELECT c.clientID, firstname, lastname, title, artist FROM users u, currentSongs c WHERE c.clientID = u.clientID and u.status='active'";
  	connection.query(query, function(err,rows) {
    	if (err) throw err;
    	res.send(rows);
    	next();
    }
  );
}

////////////////////////////////////////////////////////
// Songs
////////////////////////////////////////////////////////

//Insert song into currentSongs table
function updateSong(req,res,next){
	var query = "INSERT INTO currentSongs (clientID, title, artist, album, nsurl) VALUES(" + 
				mysql.escape(req.body.clientID) + "," +
				mysql.escape(req.body.title) + "," +
				mysql.escape(req.body.artist) + "," + 
				mysql.escape(req.body.album) + "," +
				mysql.escape(req.body.nsurl) + ") " +
				"ON DUPLICATE KEY UPDATE " + 
				"title=" + mysql.escape(req.body.title) + "," + 
				"artist=" + mysql.escape(req.body.artist) + "," +
				"album=" + mysql.escape(req.body.album) + "," +
				"nsurl=" + mysql.escape(req.body.nsurl) + ";";	
				console.log(query);	
	connection.query(query, function(err, results) {
      if(err) res.send(400);
      res.send(200);
      next();
  	});
}

//get current song from user
function getPlayingSong(req,res,next){
	var query = "SELECT title,artist,album,nsurl FROM users u, currentSongs c WHERE c.clientID='" + req.params.clientID + "' and c.clientID = u.clientID;";	
	console.log(query);	
	connection.query(query, function(err, results) {
      if(err) res.send(400);
      res.send(results);
      next();
  	});
}

//delete a user's song
function deleteSong(req,res,next){
	var query = "DELETE FROM currentSongs WHERE clientID =" + req.params.clientID + ";";		
	connection.query(query, function(err, results) {
      if(err) res.send(400);
      res.send(200);
      next();
  	});
}


function authorizeUser (req, res, next) {
  var query = "SELECT * FROM Users WHERE password = " + mysql.escape(req.body.password) + " AND email = " + mysql.escape(req.body.email) + ";";
  connection.query(query,  function(err, results){
    if (err)
      throw err;
    else if (results.length < 1)
      res.send({loggedIn:false});
    else 
      res.send({loggedIn:true});
    next();
  });
}


var server = restify.createServer();
server.use(function crossOrigin(req,res,next){
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    return next();
  });

server.use(restify.bodyParser ({mapParams: false}));

server.get('/test1',test1);

////////////////////////////////////////////////////////
// Users
////////////////////////////////////////////////////////

server.put('/users',updateUser);
server.get('/users',getUsers);
server.get('/users/active',getActiveUsers);

////////////////////////////////////////////////////////
// Songs
////////////////////////////////////////////////////////

server.put('/songs',updateSong);
server.get('/songs/:clientID',getPlayingSong);
server.del('/songs/:clientID',deleteSong);

server.listen(8080, function() {
  console.log('%s listening at %s', server.name, server.url);
});