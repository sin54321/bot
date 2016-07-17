var restify = require('restify');
var builder = require('botbuilder');
var db = require('./sql.js');

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
//var model = 'https://api.projectoxford.ai/luis/v1/application?id=aef4ffe2-876c-4695-820f-87f5f675b698&subscription-key=3f5950571ec248afb0ba581b8ee51239';
var model = 'https://api.projectoxford.ai/luis/v1/application?id=15c7213f-e527-4932-8796-1628ce0a2c74&subscription-key=3f5950571ec248afb0ba581b8ee51239';
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
				
				/*for(var i=0; i<db.result.length; i++){
					answer += i+1 +". ";
					answer += db.result[i]['question'];
					answer += "\n";

				}
				endDialog();*/
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
			var keywords = [{entity:results.response.entity}];
			db.getAnswer(keywords);
			setTimeout(function(){
				session.send('Answer: %s',db.result[0]['answer']);

			}	
			,1000);
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
				
				for(var i=0; i<db.result.length; i++){
					trips.push(db.result[i]['header']);
				}
				console.log(trips);
				builder.Prompts.choice(session,'Choose a trip: ',trips);
				
			}
			,1000);
			
		}
		else {
          session.send("Sorry, I didn't understand.");
        }
		
	},
	function(session, results){
		if (results.response){
			
			db.searchListing(results.response.entity);

			
			setTimeout(function(){
				var trip = db.result[0];
				var send = 'Trip:\n' + trip['header'] + '\n\nIntroduction:'+ trip['experience'] + '\n\nExperience:' + trip['introduction'] + '\n\nLocation:\n ' + trip['location'] + '\n\nDuration:\n' + trip['duration'] + '\n\nLanguage:\n' + trip['language'] + '\n\nPrice:\n' + trip['price'] + '\n\nIncluded:\n' + trip['included'] +  '\n\nReminder:\n' + trip['reminder'] + '\n\nLink:\n' + trip['link'];
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

//suggest user a random trip 
dialog.matches('RandomTrip', [
   function (session) {
	   db.getAllListing();
	   
		setTimeout(function(){
			var random = Math.floor((Math.random() * db.result.length));
			var randTrip = db.result[random];
			//store entities for random trip

			var trip = 'Trip:\n' + randTrip['header'] + '\n\nIntroduction:'+ randTrip['experience'] + '\n\nExperience:' + randTrip['introduction'] + '\n\nLocation:\n ' + randTrip['location'] + '\n\nDuration:\n' + randTrip['duration'] + '\n\nLanguage:\n' + randTrip['language'] + '\n\nPrice:\n' + randTrip['price'] + '\n\nIncluded:\n' + randTrip['included'] +  '\n\nReminder:\n' + randTrip['reminder'] + '\n\nLink:\n' + randTrip['link'];
			session.send(trip);
			session.endDialog();
		},1000);
    }

]);



bot.use({
    dialog: function (session) {
        session.userData.isLogging = true;
    }
});


dialog.onDefault(builder.DialogAction.send("I'm sorry I didn't understand."));


