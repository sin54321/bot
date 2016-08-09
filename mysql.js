var mysql = require('mysql');
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database:'bot_database',
    port: 3307
});

//Validate connection
connection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }

  console.log('connected as id ' + connection.threadId);
});

//Export method section
module.exports.connection = connection;
module.exports.queryFunction = queryFunction ;

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
  var phrase = "";
  var column = "";
  var logic ="";
  var value ="";
  var count_p = 0;
  //Logic

  //Location,Price,Duration
  for(var i =0; i < keywords.length; i ++){
    if(keywords[i]['type'] == "Location"){
        column = `location like `;
    }
    else if(keywords[i]['type'] == "Price"){
      switch(count_p)
      {
        case 0:
        column = `price`
        value = keywords[i]['entity'];
        break;
        case 1:
        column = keywords[i]['entity'];

      }
          count_p++;


    }

    else if(keywords[i]['type'] == "Duration"){
      column = `duration like `;
    }
    else if(keywords[i]['type'] == "Below"){
      logic = `< `;
    }
    else if(keywords[i]['type'] == "Greater"){
      logic = `> `;
    }
    else if(keywords[i]['type'] == "Equal"){
      logic = `= `;
    }
    else if(keywords[i]['type'] == "Between"){
      logic = ` between `;
    }

    if(keywords[i]['type'] == "Location" || keywords[i]['type'] == "Duration")
    phrase = phrase + column +` '%${keywords[i]['entity']}%'`;

    else if(keywords[i]['type'] == "Price")
    phrase = phrase + column;
    else if(keywords[i]['type'] == "Below" || keywords[i]['type'] == "Greater" || keywords[i]['type'] == "Equal" )
    phrase = phrase + logic + value;

    else if(keywords[i]['type'] == "Between")
    phrase = phrase + logic + value;

    if(keywords.length > 0 && i != keywords.length-1 && keywords[i]['type'] != "Price" ){
        phrase = phrase + ` and `;
    }
  }

  var query = `select header from listing where ` + phrase;
  console.log(query);
  queryFunction(query);
}


module.exports.searchListing = function searchListing(keywords){

  var query = `select * from listing JOIN package ON listing.ID = package.listingID where header = '${keywords}'`;
  queryFunction(query);

}

module.exports.getOrder = function getOrder(keywords){

  var query = `SELECT t1.*, t2.*,t3.*,t4.firstName,DATE_FORMAT(travelDate,'%d/%m/%Y') as travelDate FROM orderdetail t1, listing t2, package t3, customer t4
  WHERE t1.orderID = '${keywords[0]['entity']}' AND t1.listingID = t2.id AND t1.packageID = t3.packageID AND t1.customerID = t4.id` ;
  queryFunction(query);
}

module.exports.insertUser = function insertUser(id,name,convID){

  var query = `insert into log_user (userID, username, conversationID)
   values ('${id}','${name}','${convID}')`;
   queryFunction(query);
}


module.exports.insertConv_user = function insertConv(addid,convid,msg,idate,itime){
  
  var query = `insert into log_data ( addressID,conversationID, userReply, date, time)
   values ('${addid}','${convid}','${msg}','${idate}','${itime}')`;
   queryFunction(query);
}


module.exports.insertConv_bot = function insertConv(msg,id){
  
  var query = `update log_data set botReply = '${msg}'
  where addressID = '${id}' `;
  queryFunction(query);
}


module.exports.search_conv = function search_conv(convID){
    var query = `select * from log_user where conversationID = '${convID}'`;
    queryFunction(query);
}


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
  console.log('executed saveRecords');

  if(result)
  {
		if(result.length > 0){
    module.exports.result = result;
    }
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

 //Testing purpose
 /*
var testing = [
  { entity: 'Malaysia',
    type: 'Location',
    startIndex: 10,
    endIndex: 17,
    score: 0.9196032 } ,
     { entity: '30',
      type: 'Price',
      startIndex: 10,
      endIndex: 17,
      score: 0.9196032 },
      { entity: 'between',
       type: 'Below',
       startIndex: 10,
       endIndex: 17,
       score: 0.9196032 },

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
