var sql = require('mssql');

var config = {
	port: 1344,
    user: 'sa',
	password: '1234',
    server: 'localhost\\SQLEXPRESS01', // You can use 'localhost\\instance' to connect to named instance
    database: 'bot_database',

options: {
    encrypt: true // Use this if you're on Windows Azure
}


}
/*
//Validate connection
var connection = new sql.Connection(config, function(err) {
    // ... error checks
	if(err) throw err;
// Query

var request = new sql.Request(connection); // or: var request = connection.request();
request.query('select * from listing', function(err, listing) {
    // ... error checks
	if(err) throw err;

    console.dir(listing);
});



});
*/

//Export
module.exports.connection = new sql.Connection(config);
module.exports.request = new sql.Request(module.exports.connection);
module.exports.queryFunction = queryFunction ;
module.exports.connection.connect(function(err){
	if(err) throw err;
	console.log('connected');
});


//Sample sql query
//select chat_textContent from chat_text where chat_textContent = 'Hello!';
//select chat_textContent from chat_text where chat_textContent like 'hello%' ;
//insert into chat_text (chat_textNo,chat_textContent) values (4,'Malaysia');


//Method
module.exports.getAnswer = function getAnswer(keywords) {
  var like = "";
  for(var i =0; i < keywords.length; i ++){
    like = like + `qkey like '%${keywords[i]['entity']}%'`;
    if(keywords.length > 0 && i != keywords.length-1){
        like = like + ` and `;
    }
  }

  var query = `select question,answer from faq where ` + like;
  queryFunction(query);

}
module.exports.getAllListing = function getAllListing(){
  var query = `select * from listing`;
  queryFunction(query);
}

module.exports.getListing = function getListing(keywords){
  var like = "";
  var column = "";
  for(var i =0; i < keywords.length; i ++){
    if(keywords[i]['type'] == "Location"){
        column = `location`;
    }
    else if(keywords[i]['type'] == "Price"){
        column = `price`;
    }
    else if(keywords[i]['type'] == "Duration"){
      column = `duration`;
    }
    like = like + column +` like '%${keywords[i]['entity']}%'`;
    if(keywords.length > 0 && i != keywords.length-1){
        like = like + ` and `;
    }
  }

  var query = `select header from listing where ` + like;
  queryFunction(query);
}

module.exports.searchListing = function getListing(keywords){

  var query = `select * from listing where header = '${keywords}'`;
  queryFunction(query);

}

module.exports.getOrder = function getOrder(keywords){

  var query = `select * from orderdetail where orderID ='${keywords[0]['entity']}'`;
  queryFunction(query);
}

module.exports.getOrderDetail = function getOrderDetail(listingID){

  var query = `select header,location from listing where id ='${listingID}'`;
  queryFunction(query);
}

//Reuse method

function queryFunction(query)
{

		//module.exports.request.stream = true;
		module.exports.request.query(query, function(err, result) {
		    // ... error checks
			if(err) throw err;

				console.log('executed request query with %s',query);
				module.exports.saveRecords(result);

		});

}

module.exports.saveRecords = function saveRecords(result){
  console.log('executed saveRecords');

  if(result)
  {
		if(result.length > 0)
    module.exports.result = result;
		else
	  {
	    module.exports.result = undefined;
	  }
  }
	else
	{
		module.exports.result = undefined;
	}

  console.log(result);
}



//module.exports.getAnswer("charged"); //for testing purpose

/* Testing purpose
var testing = [
  { entity: 'Malaysia',
    type: 'Location',
    startIndex: 10,
    endIndex: 17,
    score: 0.9196032 } ,
     { entity: '8',
      type: 'Price',
      startIndex: 10,
      endIndex: 17,
      score: 0.9196032 }
];

module.exports.getListing(testing);
*/
//module.exports.getAllListing();

/* testing
var orderID = [
  {
    entity:'001A',
    type: 'OrderNumber'
  },
  {
    entity:'002B',
    type: 'OrderNumber'
  }
];
module.exports.getOrder(orderID);
*/
//module.exports.getOrderDetail("001A");
//module.exports.getAllListing();
