var restify = require('restify');
var builder = require('botbuilder');
var db = require('./mysql.js');
var message_sent;

// Create bot and bind to console
// Setup Restify Server
var server = restify.createServer();
server.listen(process.env.port || process.env.PORT || 3978, function () {
   console.log('%s listening to %s', server.name, server.url);
});

// Create chat bot
var connector = new builder.ChatConnector({
    appId: process.env.MICROSOFT_APP_ID,
    appPassword: process.env.MICROSOFT_APP_PASSWORD
});
var bot = new builder.UniversalBot(connector);
server.post('/api/messages', connector.listen());

// Create LUIS recognizer that points at our model and add it as the root '/' dialog for our Cortana Bot.
var model = 'https://api.projectoxford.ai/luis/v1/application?id=aef4ffe2-876c-4695-820f-87f5f675b698&subscription-key=3f5950571ec248afb0ba581b8ee51239';
var recognizer = new builder.LuisRecognizer(model);
var dialog = new builder.IntentDialog({ recognizers: [recognizer] });
bot.dialog('/', dialog);


// Add intent handlers
dialog.matches('FAQ', [
    function (session, args) {
        // Prompt for title
        //show me the trip in peneng price bellow rm80
        var qkey = builder.EntityRecognizer.findAllEntities(args.entities,'QuestionKey');
		var answer = [],message=null;

          console.log(qkey);
        if(qkey.length>0)
        {
			db.getAnswer(qkey);

			//setTimeout to run function after db.getAnswer finished executed;
			setTimeout(function(){
			if (db.result.length>1){


				for(var i=0; i<db.result.length; i++){

					answer.push(db.result[i]['question']);

				}
				message='Did you mean: ';
				builder.Prompts.choice(session,message,answer);
				message += answer;
				log_output(message,session);


			}
			else if(db.result.length=1){

				message = 'Answer: '+ db.result[0]['answer'];
				session.send(message);
				log_output(message,session);

			}

          },1000);
        }
        else {
			message ="Sorry, I didn't understand.";
          session.send(message);
		  log_output(message,session);
        }

    },
	function (session, results) {
		var message=null;
		if (results.response){
			for(var i=0;i<db.result.length;i++)
			  {
				if(results.response.entity == db.result[i]['question'])
				var answer = db.result[i]['answer'];
			  }

			setTimeout(function(){
				if(answer){
					message = "Answer: " + answer;
					session.send(message);
					log_output(message,session);
				}
				else {
					message = "No such answer for the question"
				  session.send(message);
				  log_output(message,session);
				}

			},1000);

		}
		session.endDialog();
	}

]);


//List trip avalable if user search for it
dialog.matches('Listing',[
	function(session, args){
		var trips=[];
		var trip_loc = builder.EntityRecognizer.findAllEntities(args.entities,'Location');
		var duration = builder.EntityRecognizer.findAllEntities(args.entities,'Duration');
		var price = builder.EntityRecognizer.findAllEntities(args.entities,'Price');

	    var greater = builder.EntityRecognizer.findAllEntities(args.entities,'Greater');
	    var below = builder.EntityRecognizer.findAllEntities(args.entities,'Below');
	    var equal = builder.EntityRecognizer.findAllEntities(args.entities,'Equal');
	    var between = builder.EntityRecognizer.findAllEntities(args.entities,'Between');

	    var category = builder.EntityRecognizer.findAllEntities(args.entities,'Category');
			var entity = [];

	    if(greater)
	    console.log(greater);
	    if(below)
	    console.log(below);
	    if(equal)
	    console.log(equal);
	    if(between)
	    console.log(between);
	    if(category)
	    console.log(category);

		//console.log(trip_loc);
		//console.log(duration);
		//console.log(price);

		if(trip_loc){
			for(var i=0;i<trip_loc.length;i++){
				entity.push(trip_loc[i]);
			}
		};

		if(duration){
			for(var i=0;i<duration.length;i++){
				entity.push(duration[i]);
			}
		};

		if(price){
			for(var i=0;i<price.length;i++){
				entity.push(price[i]);
			}
		};

    if(greater){
			for(var i=0;i<greater.length;i++){
				entity.push(greater[i]);
			}
		};
    if(equal){
			for(var i=0;i<equal.length;i++){
				entity.push(equal[i]);
			}
		};
    if(below){
			for(var i=0;i<below.length;i++){
				entity.push(below[i]);
			}
		};
    if(between){
			for(var i=0;i<between.length;i++){
				entity.push(between[i]);
			}
		};

    console.log('/====entity====/');
		console.log(entity);
    console.log('/====entity====/');
		if(entity.length>0)
        {
			db.getListing(entity);

			setTimeout(function(){
				//console.log(db.result);
				if(db.result){
					for(var i=0; i<db.result.length; i++){
						trips.push(db.result[i]['header']);
					}
					console.log(trips);
					var message = 'Choose a trip: ';
					builder.Prompts.choice(session,message,trips);
					message+=  trips;
					log_output(message,session);
				}else{
					var message='Sorry, no results.';
					session.send(message);
					log_output(message,session);
				}

			}
			,1000);

		}
		else {

			//random trip for user
			db.getAllListing();

			setTimeout(function(){
			//console.log(db.result);
			var random = Math.floor((Math.random() * db.result.length));
			var randTrip = db.result[random];
			db.searchListing(randTrip['header']);
			//store entities for random trip
			var packages = '';
			setTimeout(function(){
				//for loop to display packages
				for(var i = 0; i<db.result.length;i++)
				{
					packages = packages + db.result[i]['packageTitle'];
					if(i != db.result.length-1)
					packages += ' , ';
				  }

				var trip =
					'Trip:\n' + randTrip['header'] +
					'\n\nIntroduction:'+ randTrip['introduction'] +
					'\n\nExperience:' + randTrip['experience'] +
					'\n\nLocation:\n ' + randTrip['location'] +
					'\n\nDuration:\n' + randTrip['duration'] +
					'\n\nLanguage:\n' + randTrip['language'] +
					'\n\nPrice:\n' +   randTrip['price'] +
					'\n\nPackages:\n' + packages +
					'\n\nIncluded:\n' +   randTrip['included'] +
					'\n\nReminder:\n' +   randTrip['reminder'] +
					'\n\nLink:\n' + randTrip['link'];

					session.send(trip);

					log_output(trip,session);

					session.endDialog();
				},1000);
			},1000);
        }

	},
	function(session, results){
		if (results.response){

			db.searchListing(results.response.entity);
			var packages = '';
			setTimeout(function(){
				//for loop to display packages
				for(var i = 0; i<db.result.length;i++)
				{
				  packages = packages + db.result[i]['packageTitle'];
				  if(i != db.result.length-1)
				  packages += ' , ';
				}

				var trip = db.result[0];
				console.log(db.result);
				var send =
				'Trip:\n' + trip['header'] +
				'\n\nIntroduction:'+ trip['introduction'] +
				'\n\nExperience:' + trip['experience'] +
				'\n\nLocation:\n ' + trip['location'] +
				'\n\nDuration:\n' + trip['duration'] +
				'\n\nLanguage:\n' + trip['language'] +
				'\n\nPrice:\n' + trip['price'] +
				'\n\nPackages:\n' + packages +
				'\n\nIncluded:\n' + trip['included'] +
				'\n\nReminder:\n' + trip['reminder'] +
				'\n\nLink:\n' + trip['link'];
				session.send(send);
				log_output(send,session);

		  }
      ,1000);

		}
		session.endDialog();

}]);

//Greeting to the user
dialog.matches('Greeting',[
	function (session) {
		var message ='Hi! Welcome to ChatBot for Departsoon!!!';
        session.send(message);
		log_output(message,session);
	}
]);

//if user need help
dialog.matches('Help',[
	function (session) {
		var message = 'This is chatbot for Departsoon.\n\nWhat this bot can do: \n\n'+
						'Search Package: This bot can let you search package by location, price, category and duration of trip. '+'\n\n     Example: Trip in Malaysia \n\n'+
						'Random Package: You can get details for a random trip privided. '+'\n\n     Example:random trip\n\n'+
						'Check Order Details: You can get your order details using your order number. '+'\n\n     Example: order number 001A \n\n'+
						'FAQ: The bot will answer your questions according to the FAQ ';
        session.send(message);
		log_output(message,session);
	}
]);


//when user check their ordered trip package using order number
dialog.matches('Order', [
   function(session, args){

	   var order_num = builder.EntityRecognizer.findAllEntities(args.entities,'OrderNumber');
	   var message=null;
	   if (order_num.length>0){
		   var order_details ='';
		   console.log(order_num);
		   db.getOrder(order_num);

		   setTimeout(function(){

			   if(db.result){

				   setTimeout(function(){

					   order_details =
             'Hi '+db.result[0]['firstName']+', here is your order:'+
             '\n\nOrder ID:'+db.result[0]['orderID']+
             '\n\nTrip:'+db.result[0]['header']+
             '\n\nLocation:'+db.result[0]['location']+
             '\n\nPackage:'+db.result[0]['packageTitle']+
             '\n\nTotal Price:'+db.result[0]['totalPrice']+
             '\n\nDate:'+db.result[0]['travelDate']+
             '\n\nDuration:'+db.result[0]['tripduration']+
             '\n\nNumber of People:'+db.result[0]['totalNumOfPeople'];
					   console.log(order_details);
					   console.log(db.result);
             session.endDialog(order_details);
			 log_output(order_details,session);

				   },1000);
			   }
			   else{
				   message="Sorry no result for the order number.";
					session.send(message);
					log_output(message,session);
					session.endDialog();

			   }
		   },1000);
	   }
	   else{
		   message ="Please enter your order number!";
		   session.send(message);
		   log_output(message,session);
		   session.endDialog();
	   }

    }

]);


bot.use(
	{
	botbuilder: function (session, next) {

		//log user name and user id if conversation id is not detected
	    if (!session.userData.firstRun) {

	        session.userData.firstRun = true;
	        console.log('---------------------validate user data-------------------------');
	        console.log(session.message.address.user.id);
		    console.log(session.message.address.user.name);
		    console.log(session.message.address.conversation.id);

		   	//confirm if the conversation ID exist
		   	db.search_conv(session.message.address.conversation.id);

		   	setTimeout(function(){

		   		if(db.result == undefined){
		   			db.insertUser(session.message.address.user.id , session.message.address.user.name , session.message.address.conversation.id);
		   		}

				console.log(db.result);

		   },1000);

	    }

	    setTimeout(function(){

	        console.log('Message Received: ', session.message.text);


	        var inputDate='',inputTime='';
			var timestamp = session.message.timestamp;
			console.log(timestamp);

			//split timestamp into date and time
			//date
	        var pos = timestamp.indexOf('T');
	        for (var i = 0; i < pos; i++)
	        	inputDate += timestamp[i];
	        console.log(inputDate);

	        //time
	        var pos2 = timestamp.indexOf('.');
	        for (var i = pos+1; i < pos2; i++)
	        	inputTime += timestamp[i];
	        console.log(inputTime);


	        console.log(session.message.address.conversation.id);

	   
	        db.insertConv_user(session.message.address.id, session.message.address.conversation.id, session.message.text, inputDate, inputTime);
			next();
			},1000);

    	}
});



//logging the output of the bot
function log_output(message,session){

	console.log('Message sent:',message);
	console.log('Log output');
	message = message.replace("'","''");
	db.insertConv_bot(message,session.message.address.id);

}



//default dialog
dialog.onDefault(builder.DialogAction.send("I'm sorry I didn't understand."));
