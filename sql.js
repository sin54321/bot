var async = require('async');
var mysql = require('mysql');
var connection = mysql.createConnection({
	port: 3307,
    host: 'localhost',
    user: 'root',
    password: '',
    database:'bot_database',
});


//Validate connection
connection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }

  console.log('connected as id ' + connection.threadId);
});
//Sample sql query
//select chat_textContent from chat_text where chat_textContent = 'Hello!';
//select chat_textContent from chat_text where chat_textContent like 'hello%' ;
//insert into chat_text (chat_textNo,chat_textContent) values (4,'Malaysia');

//Export method section
module.exports.connection = connection;
module.exports.queryFunction = queryFunction ;

//Method
module.exports.getAnswer = function getAnswer(keywords) {
  var like = "";
  for(var i =0; i < keywords.length; i ++){
    like = like + `question like '%${keywords[i]['entity']}%'`;
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

module.exports.getOrderDetail = function getOrderDetail(orderID){

  var query = `select header,location from listing where id ='${orderID}'`;
  queryFunction(query);
}

module.exports.get
//Reuse method
function queryFunction(query)
{
  module.exports.connection.query(query, function(err, result) {
  if (err)
    {
      //if else loop for it to reconnect if the connection is lost
      if (err.code === 'PROTOCOL_CONNECTION_LOST') {
        connect();
      } else {
        console.error(err.stack || err);
      }
    }
  else
  {
    console.log(query);
    module.exports.saveRecords(result);

  }

  });
}

module.exports.saveRecords = function saveRecords(result){
  console.log('executed');
  if(result.length > 0)
  {
    module.exports.result = result;
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
