var restify = require('restify');
var builder = require('botbuilder');
var db = require('./sqlFAQ.js');

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

var model = 'https://api.projectoxford.ai/luis/v1/application?id=15c7213f-e527-4932-8796-1628ce0a2c74&subscription-key=3f5950571ec248afb0ba581b8ee51239';
var recognizer = new builder.LuisRecognizer(model);
var dialog = new builder.IntentDialog({ recognizers: [recognizer] });
bot.dialog('/', dialog);


// Add intent handlers
dialog.matches('FAQ', [
    function (session, args,results) {
        // Prompt for title
        //show me the trip in peneng price bellow rm80
        var qkey = builder.EntityRecognizer.findAllEntities(args.entities,'QuestionKey');
          console.log(qkey);
          if(qkey.length>0)
        {  db.getAnswer(qkey);
          //setTimeout(function(){},1000);
          setTimeout(function(){

            session.send('Answer: %s',db.answer[0]['answer']);
            session.endDialog();

          },1000);
        }
        else {
          session.endDialog("Sorry, I didn't understand.");
        }

    }


]);

dialog.matches('Greeting',[
	function (session) {
        session.send('Hi! Welcome to ChatBot for Departsoon!!!');
	}
]);

dialog.matches('Help',[
	function (session) {
        session.send('This bot can let user to search about the travelling package from departsoon and answer users question according to the FAQ. \nUser can also request for random trip package.');
	}
]);

dialog.matches('RandomTrip', [
   function (session) {

		var random = Math.floor((Math.random() * data.length));
		var randTrip = data[random];
		//store entities for random trip

		var trip = 'Trip:\n' + randTrip['trip'] + '\n\nIntroduction:' + randTrip['introduction'] + '\n\nLocation:\n ' + randTrip['location'] + '\n\nDuration:\n' + randTrip['duration'] + '\n\nLanguage:\n' + randTrip['language'] + '\n\nPrice:\n' + randTrip['price'] + '\n\nIncluded:\n' + randTrip['included'] + '\n\nPackage:\n' + randTrip['pack'] + '\n\nReminder:\n' + randTrip['reminder'] + '\n\nLink:\n' + randTrip['link'];
		session.send(trip);
		session.endDialog();
    }

]);

bot.use({
    dialog: function (session) {
        session.userData.isLogging = true;
    }
});


dialog.onDefault(builder.DialogAction.send("I'm sorry I didn't understand."));


//sample data
var data = [
  {
	  trip: 'Nictar Symbiosis Farm Tour',
      location: 'Malaysia , Pekan Nenas, Kuala Lumpur',
      duration: '2 hours',
      language: 'English, Mandarin, Malay, Cantonese ',
      price: 'from MYR 14',
	  introduction: 'At Nictar Symbiosis Farm, you are not just seeing the pineapple farm, you will see how different living creatures grow and live together.',
	  pack: ['Farm visit + Pineapple juice','Farm visit'],
	  included: ['Pineapple','Farm tour'],
      Reminder: ['Minimum 10 people in order to fullfill this trip. In the event if participant is less than 10 people, the tour will be cancelled, a cancellation E-mail notification will be sent 1 days before departure.','In the event of typhoons, storms and other poor weather, we will determine whether we will cancel the tour 0 day before departure at local time 9:00 and notify customer via Email.'],
      //Experience: 'Nictar Symbiosis Farm is located in Pontian\'s Parit Sikom. \nIn short, symbiosis means different living organisms grow together at the same location. \nOur farm has a total area of 10 acres. We have grow several species of pineapple, bees, chicken, and some dogs to guard our farm! And best of all, they all coexist in the farm and bring benefits to one another.\nCome here to learn the concept of symbiosis and knowledge of pineapple. You will love eating pineapple again after this tour.',
	  link: 'https://www.departsoon.com/en/tour/16/nictar-symbiosis-farm-tour'
  },
  {
	  trip: 'Glow in dark 3D art',
      location: 'Malaysia , Johor Bahru',
      duration: '2 hours',
      language: 'English, Mandarin, Malay, Cantonese',
	  price: 'from MYR 25',
      introduction: 'Ever seen 3D art glowing in the dark? At Dark Art 3D Studio you will get to see what we called as "2-in-1 3D art".',
	  pack: ['-'],
	  included: ['Entrance'],
      Reminder: '-',
      //Experience: 'Dark Art 3D Studio is not your usual 3D art gallery.\n At Dart Art 3D Studio, every art has 2 presentations. \nThe very same art will look differently in different lighting condition.\nVisitors can take a photo with the 3D poster under normal fluorescent lighting. When the light turned off, the art will be glowing in the dark and different layer will appear. \nCome and take some creative photo with your wildest imagination.',
	  link: 'https://www.departsoon.com/en/tour/14/glow-in-dark-3d-art'
  },
  {
	  trip: 'Container Gardenstay',
      location: 'Malaysia , Johor Bahru',
      duration: '-',
      language: 'English, Mandarin, Malay, Cantonese',
	  price: 'from MYR 180',
      introduction: 'Whether you are instagramer, foodie, or just hopping around, Container Gardenstay is an unique staying experience for all kind of people.',
	  pack: ['-'],
	  included: 'Lunch/Dinner(Pandan Chicken, Tom yum, Sambal Kangkong )',
      Reminder: '-',
      //Experience: 'Located at Taman Desa Tebrau, Container Gardenstay in the compound of the famous Thai Food Restaurant - Bangkok Village. \nContainer Gardenstay is built using several containers. We first saw this new hotel concept in foreign country and then we decided to bring this concept into Johor Bahru. \nEvery container room will have full facilities such as a bathroom, bathroom amenities, television, WiFi internet, big comfy bed, and also window view. \nWe also provide light breakfast for our hotel guest and also dinner for 2 at Bangkok Village restaurant (Only for departsoon\'s buyer).\nBesides, Container Gardenstay is near to many hotspot or business area such as Aeon, Tesco, Johor Jaya.',
	  link: 'https://www.departsoon.com/en/tour/12/container-gardenstay'
  },
  {
	  trip: 'World Class Classical Guitarist Samuel Klemke live in Pontian',
      location: 'Malaysia , Pekan Nenas',
      duration: '2 hours  ',
      language: 'Mandarin ',
	  price: 'from MYR 30',
      introduction: 'World Class Classical Guitarist Samuel Klemke live in Pontian, Johor',
	  pack: ['-'],
	  included: 'concert',
      Reminder: '-',
      //Experience: 'World class classical guitarist from Germany, for the first time, visit Johor to perform a tour concerts, and he is coming to Pontian, Johor to perform the aforesaid concert on 17th of June, 2015 venue as below:\n\nVenue: 笨珍培群独立中学李织霞讲堂 \nTime: 8pm ',
	  link: 'https://www.departsoon.com/en/tour/24/world-class-classical-guitarist-samuel-klemke-live-in-pontian'
  }
];
