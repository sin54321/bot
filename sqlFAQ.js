
var mysql = require('mysql');
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database:'bot_database',
    port: 3306
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
module.exports.connection = connection;

module.exports.getAnswer = function getAnswer(keywords) {
  var like = "";
  for(var i =0; i < keywords.length; i ++){
    like = like + `question like '%${keywords[i]['entity']}%'`;
    if(keywords.length > 0 && i != keywords.length-1){
        like = like + ` and `;
    }
  }

  var query = `select answer from faq where ` + like;
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
      module.exports.saveRecords(result);

    }

  });

}


module.exports.saveRecords = function saveRecords(result){
  console.log('executed');
  if(result.length > 0)
  {
    module.exports.answer = result;
  }
  else
  {
    module.exports.answer = undefined;
  }

  console.log(result);
  //connection.end(); // The connection is terminated now // not used for now
}



//module.exports.getAnswer("charged"); //for testing purpose
