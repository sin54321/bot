var restify = require('restify');
var builder = require('botbuilder');
var db = require('./mssql.js');
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
		var answer = [];

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
				builder.Prompts.choice(session,'Did you mean: ',answer);


			}
			else if(db.result.length=1){

				session.send('Answer: %s',db.result[0]['answer']);

			}

          },1000);
        }
        else {
          session.send("Sorry, I didn't understand.");
        }

    },
	function (session, results) {
		if (results.response){
			for(var i=0;i<db.result.length;i++)
			  {
				if(results.response.entity == db.result[i]['question'])
				var answer = db.result[i]['answer'];
			  }

			setTimeout(function(){
				if(answer)
						session.send('Answer: %s',answer);
				else {
				  session.send("No such answer for the question");
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
		var entity = [];
		console.log(trip_loc);
		console.log(duration);
		console.log(price);

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

		console.log(entity);
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
					builder.Prompts.choice(session,'Choose a trip: ',trips);
				}else{
					session.send('Sorry, no results.');
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

        packages = '';
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

      }
      ,1000);

		}
		session.endDialog();

	}

]);

//Greeting to the user
dialog.matches('Greeting',[
	function (session) {
        session.send('Hi! Welcome to ChatBot for Departsoon!!!');
	}
]);

//if user need help
dialog.matches('Help',[
	function (session) {
        session.send('This bot can let user to search about the travelling package from departsoon and answer users question according to the FAQ. \nUser can also request for random trip package.');
	}
]);

//when user check their ordered trip package using order number
dialog.matches('Order', [
   function(session, args){

	   var order_num = builder.EntityRecognizer.findAllEntities(args.entities,'OrderNumber');
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
             '\n\nDuration:'+db.result[0]['duration']+
             '\n\nNumber of People:'+db.result[0]['totalNumOfPeople'];
					   console.log(order_details);
					   console.log(db.result);
             session.endDialog(order_details);

				   },1000);
			   }
			   else{
					session.send("Sorry no result for the order number.");
					session.endDialog();

			   }
		   },1000);
	   }
	   else{
		   session.send("Please enter your order number!");
		   session.endDialog();
	   }

    }

]);



bot.use({
    botbuilder: function (session, next, args) {

        console.log('Message Received: ', session);
		console.log('Message Received: ', args);
		next();
    }

});


dialog.onDefault(builder.DialogAction.send("I'm sorry I didn't understand."));
