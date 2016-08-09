-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2016 at 02:12 AM
-- Server version: 5.7.13-log
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bot_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `id` int(4) NOT NULL,
  `emailAddress` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `gender` enum('m','f') NOT NULL,
  `birthDate` date NOT NULL,
  `phoneNum` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `emailAddress`, `password`, `firstName`, `lastName`, `gender`, `birthDate`, `phoneNum`, `address`, `description`) VALUES
(1, 'naijun@hotmail.com', '123456', 'Pong', 'Nai Jun', 'm', '2016-01-01', '0123456789', 'Taman bunga', 'i love trips'),
(2, 'calvin@yahoo.com', '654321', 'Calvin S''ng', 'Kai Vee', 'm', '2016-01-01', '0193456789', 'Taman matahari', 'Trip is life'),
(3, 'rose@aol.com', '987654', 'Rose', 'Maria', 'f', '2016-01-01', '0183456789', 'Taman air', 'trip is belief.');

-- --------------------------------------------------------

--
-- Table structure for table `faq`
--

CREATE TABLE IF NOT EXISTS `faq` (
  `id` int(4) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` varchar(999) NOT NULL,
  `qkey` varchar(999) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faq`
--

INSERT INTO `faq` (`id`, `question`, `answer`, `qkey`) VALUES
(1, 'How can I purchase packages/services on this website?', 'First, you will need to register as a user. Login to your account, choose a tour, select the “book” button and follow the instructions.', 'how, purchase, buy, website ,packages, services, trips'),
(2, 'When will I be charged for the payment?', 'After you make a request, we will prompt the seller/tour operator to confirm the request. Upon his/her confirmation, the transaction will be made. But you can amend/cancel your booking at any time before that happens.', 'charged,charge,payment,money,credit,when,bill'),
(3, 'When and how do I know that the order is confirmed?', 'After the seller/tour operator confirms your request, your booking status will be updated. You will also receive a confirmation email.', 'when,how,order,confirmed,confirm,know'),
(4, 'Can I change my order after the payment is made?', 'After the payment is made, the order cannot be changed, i.e., adding more tour members or requesting a different starting time. But you can still cancel the order, see below.', 'change,order,payment,made,make,changed,paid,can,after'),
(5, 'Can I cancel the order and receive a refund?', 'Yes, you can cancel the order. Depending on the refund policy, a complete/partial refund can be made. See refund policy for details.', 'cancel,refund,cancellation,money,back,can'),
(6, 'How do I communicate with the seller?', 'After a tour is confirmed by both parties, you can contact the seller through the messenger service.', 'communicate,seller,talk,message,provider,how'),
(7, 'What if the seller/tour guides don’t show up?', 'You should contact us as soon as possible. Since we will hold the transaction before the tour is completed, upon verification, we will proceed by returning a full refund to you.', 'seller,tour,guide,show,up,disappear,gone,missing,what'),
(8, 'How do I review the package/services?', 'After you complete the tour, an email will be sent to your email account. You can make your comments/reviews through a link in the email.', 'review,packages,services,comments,how'),
(9, 'What are the requirements for user to sign up as seller/tour operator on departsoon.com?', 'There is no specifc requirement to register as seller/tour operator at www.departsoon.com. We welcome you to sign up as long as you have the passion in sharing the local culture with people around the globe, including but not limited to providing private tour guiding service, transportation service, ticketing service, accommodation and others.', 'requirements,sign,up,seller,tour,guides,register,operator,what'),
(10, 'When can a signed up seller/tour operator start to sell their listing?', 'You can start to sell your listing once your account has been verified.', 'signed,up,seller,tour,guides,listing,when,operator,start,when'),
(11, 'When seller/tour operator get their payment?', 'There will be a grace period for 3 working days after the tour ended. The payment will be issued to seller/ tour operator on the following Wednesday after the grace period.', 'when,seller,tour,guides,get,payment,paid,money,receive,operator'),
(12, 'How Departsoon pay out to sell/tour operator?', 'Departsoon will issue the payment to seller/tour operator via telegraphic transfer to their selected bank account.', 'pay,out,seller,tour,guides,payment,issue,departsoon,how,operator');

-- --------------------------------------------------------

--
-- Table structure for table `listing`
--

CREATE TABLE IF NOT EXISTS `listing` (
  `id` int(4) NOT NULL,
  `header` varchar(255) NOT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `price` float NOT NULL,
  `introduction` varchar(999) DEFAULT NULL,
  `experience` varchar(9999) DEFAULT NULL,
  `reminder` varchar(999) DEFAULT NULL,
  `link` varchar(255) NOT NULL,
  `location` varchar(50) NOT NULL,
  `language` varchar(50) NOT NULL,
  `included` varchar(999) NOT NULL,
  `excluded` varchar(255) NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `listing`
--

INSERT INTO `listing` (`id`, `header`, `duration`, `price`, `introduction`, `experience`, `reminder`, `link`, `location`, `language`, `included`, `excluded`, `category`) VALUES
(1, 'World Class Classical Guitarist Samuel Klemke live in Pontian', '2 hours', 30, 'World Class Classical Guitarist Samuel Klemke live in Pontian, Johor', 'World class classical guitarist from Germany, for the first time, visit Johor to perform a tour concerts, and he is coming to Pontian, Johor to perform the aforesaid concert on 17th of June, 2015 venue as below:\r\n\r\nVenue: 笨珍培群独立中学李织霞讲堂\r\nTime: 8pm ', NULL, 'https://www.departsoon.com/en/tour/24/world-class-classical-guitarist-samuel-klemke-live-in-pontian', 'Malaysia , Pekan Nenas', 'Mandarin ', 'concert', '', 'Ticket / Coupon'),
(2, 'Kulai Rainforest 1 Day Experience Tour', '8 hours', 45, 'Ever tried or fancy to sleep in a tree house? At Kulai Rainforest Tree House you will enjoy everything nature has to offer.', 'At Kulai Rainforest Tree House, all our treehouses are built in a very environmentally friendly way. \r\n\r\nWe used natural material from the forest to build treehouses. All small trunks are well preserved.\r\n\r\nEach treehouse is unique because they are built according to the hill contour and position of the tree trunks.\r\n\r\nEach treehouse has all the basic of a house, toilet, bathroom, ladder, bed, mosquito net, window, and also electricity with minimal lighting and fan. No aircon, though. But hey, who still needs aircon in the forest.\r\n\r\nTreehouse aside, you can also participate in activities such as jungle trekking, waterfall, and some learning sessions.\r\n\r\nAt night, you will join every guest of the night at the pavilion hall for dinner and listen to the briefing by the owner.\r\n\r\nActivity included :\r\nBriefing of tree house concept (natural building ,organic farming etc ) \r\nGuide to jungle walk and waterfall.\r\n\r\nCheck in at about 2pm and check out at about 12 pm. (Can still stay at our hall and play at river after u check out)\r\n\r\nDetails of the room:\r\n4 small tree house {Small tree house can fix 6 pax for (max)} ;\r\n2 big tree house {Big tree house can fix 12 pax (max).}\r\n\r\n10 minutes mountain walking distance to the first tree house (about 300 stair steps),\r\n\r\nAmenities include: \r\npower plug, mosquito net, blanket, cotton pillow, comfortable mattress bathroom with cold stream water shower and toilet bowl.\r\n\r\n\r\nThings to bring:\r\nWater bottle, backpack, clothes (long pants to avoid insect), towel, toiletries, insect\r\nrepellent, umbrella (for back up use)', 'Minimum 20 people in order to fullfill this trip.\r\nIn the event if participant is less than 20 people, the tour will be cancelled, a cancellation E-mail notification will be sent 7 days before departure.', 'https://www.departsoon.com/en/tour/23/kulai-rainforest-1-day-experience-tour', 'Malaysia , Kulai, Johor Bahru', 'English, Mandarin, Cantonese ', 'Lunch,Green Bean Soup', 'Other Expenses', 'Day Tour'),
(3, 'Kota Rainforest Resort Outdoor Activities', NULL, 19, 'Kota Rainforest Resort provide all ranges of outdoor activities. Come here to join activities with beautiful rainforest surrounding you.', 'Choose any 4 activities from:\r\nAbseiling (min 6 pax)\r\nFlying Fox (min 6 pax)\r\nRock Wall (min 6 pax)\r\nPaint Ball(target shooting) (min 4 pax)\r\nKayaking (min 2 pax)\r\nRainforest Trek (min 6 pax)\r\nRafting (min 8 pax)\r\nIndiana Jones (min 4 pax)', NULL, 'https://www.departsoon.com/en/tour/22/kota-rainforest-resort-outdoor-activities', 'Malaysia , Kota Tinggi', 'English, Malay, Mandarin', 'Entrance fee for activities only', 'Stay', 'Ticket / Coupon'),
(4, 'Kota Rainforest Resort & Activities', '48 hours', 672, 'At Kota Rainforest Resort you will be amazed by the surrounding rainforest and the range of activities we provide.', 'Need a quick getaway? Kota Rainforest Resort at Johor''s Kota Tinggi may be your best choice.\r\n\r\nThis place is so hideous that usually not many car passes by. And with all the rainforest surrounding the resort, you will surely have a relaxing getaway at Kota Rainforest Resort.\r\n\r\nBesides, we will bring you to the famous Kota Tinggi Waterfall which is just few minutes away from our resort.\r\n\r\nSecondly, we will take you to Kota Tinggi Firefly Park. You will be riding on a boat and enjoy the beautiful scenic.', NULL, 'https://www.departsoon.com/en/tour/21/kota-rainforest-resort-activities', 'Malaysia , Kota Tinggi', 'English, Mandarin, Malay, Cantonese ', 'Quad Sharing Room , Breakfast , Dinner , Waterfall Tour , Accommodation  ,Paintball (target shooting) , Kayaking', 'Personal Expenses', 'Homestay / Resort'),
(5, 'Claycup making at Platform Coffee & Homestay', '24 hours', 96, 'Recharge yourself in this peace and quient small town. Plus you get to learn how to hand made a ceramic cup!', 'Platform Coffee & Homestay is neither your ordinary coffee cafe nor usual new village homestay.\r\n\r\nOur motto for Platform Coffee & Homestay is to provide everyone a "platform" to rest their mind and recharge themselves, before going back to their busy life.\r\n\r\nBesides providing great coffee beverage and good night sleep, we thought there are more ways to release stress. Hand-making ceramic cup may be a good idea.\r\n\r\nAt Platform Coffee & Homestay we provide learning session for newbie to learn the process of ceramic cup making. At the end of the process, you may bring your cup back home or leave it here and use it during your visit.\r\n\r\nCome and explore us more!\r\n', NULL, 'https://www.departsoon.com/en/tour/17/claycup-making-at-platform-coffee-homestay', 'Malaysia , Pekan Nenas, Johor Bahru', 'English, Mandarin, Malay, Cantonese ', 'Porcelain cup learning session', '', 'Homestay / Resort'),
(6, 'Nictar Symbiosis Farm Tour', '2 hours ', 14, 'At Nictar Symbiosis Farm, you are not just seeing the pineapple farm, you will see how different living creatures grow and live together.', 'Nictar Symbiosis Farm is located in Pontian''s Parit Sikom.\r\n\r\nIn short, symbiosis means different living organisms grow together at the same location.\r\n\r\nOur farm has a total area of 10 acres. We have grow several species of pineapple, bees, chicken, and some dogs to guard our farm! And best of all, they all coexist in the farm and bring benefits to one another.\r\n\r\nCome here to learn the concept of symbiosis and knowledge of pineapple. You will love eating pineapple again after this tour.\r\n', 'Minimum 10 people in order to fullfill this trip.\r\nIn the event if participant is less than 10 people, the tour will be cancelled, a cancellation E-mail notification will be sent 1 days before departure.\r\n\r\nIn the event of typhoons, storms and other poor weather, we will determine whether we will cancel the tour 0 day before departure at local time 9:00 and notify customer via Email.', 'https://www.departsoon.com/en/tour/16/nictar-symbiosis-farm-tour', 'Malaysia , Pekan Nenas, Kuala Lumpur', 'English, Mandarin, Malay, Cantonese ', 'Pineapple juice , Farm Tour', 'other expenses', 'Private Guide'),
(7, 'Kulai Rainforest Tree House Stay And Activities', '48 hours', 260, 'Ever tried or fancy to sleep in a tree house? At Kulai Rainforest Tree House you will enjoy everything nature has to offer.', 'At Kulai Rainforest Tree House, all our treehouses are built in a very environmentally friendly way. \r\n\r\nWe used natural material from the forest to build treehouses. All small trunks are well preserved.\r\n\r\nEach treehouse is unique because they are built according to the hill contour and position of the tree trunks.\r\n\r\nEach treehouse has all the basic of a house, toilet, bathroom, ladder, bed, mosquito net, window, and also electricity with minimal lighting and fan. No aircon, though. But hey, who still needs aircon in the forest.\r\n\r\nTreehouse aside, you can also participate in activities such as jungle trekking, waterfall, and some learning sessions.\r\n\r\nAt night, you will join every guest of the night at the pavilion hall for dinner and listen to the briefing by the owner.\r\n\r\nActivity included :\r\nBriefing of tree house concept (natural building ,organic farming etc ) \r\nGuide to jungle walk and waterfall.\r\n\r\nCheck in at about 2pm and check out at about 12 pm. (Can still stay at our hall and play at river after u check out)\r\n\r\nDetails of the room:\r\n4 small tree house {Small tree house can fix 6 pax for (max)} ;\r\n2 big tree house {Big tree house can fix 12 pax (max).}\r\n\r\n10 minutes mountain walking distance to the first tree house (about 300 stair steps),\r\n\r\nAmenities include: \r\npower plug, mosquito net, blanket, cotton pillow, comfortable mattress bathroom with cold stream water shower and toilet bowl.\r\n\r\n\r\nThings to bring:\r\nWater bottle, backpack, clothes (long pants to avoid insect), towel, toiletries, insect\r\nrepellent, umbrella (for back up use)', NULL, 'https://www.departsoon.com/en/tour/15/kulai-rainforest-tree-house-stay-and-activities', 'Malaysia , Kulai', 'English, Mandarin, Malay, Cantonese ', 'Jungle trekking , Guide to Waterfall,  1 Dinner (simple vege steamboat), 1 breakfast (nasi lemak); for 2Days 1Night  2dinner ,2breakfast ,1lunch for 3Days 2Nights', 'Personal expenses', 'Homestay / Resort'),
(8, 'Glow in dark 3D art', '2 hours', 25, 'Ever seen 3D art glowing in the dark? At Dark Art 3D Studio you will get to see what we called as "2-in-1 3D art".', 'Dark Art 3D Studio is not your usual 3D art gallery. \r\n\r\nAt Dart Art 3D Studio, every art has 2 presentations.\r\n\r\nThe very same art will look differently in different lighting condition.\r\n\r\nVisitors can take a photo with the 3D poster under normal fluorescent lighting. When the light turned off, the art will be glowing in the dark and different layer will appear.\r\n\r\nCome and take some creative photo with your wildest imagination.', NULL, 'https://www.departsoon.com/en/tour/14/glow-in-dark-3d-art', 'Malaysia , Johor Bahru', 'English, Mandarin, Malay, Cantonese ', 'Entrance', '', 'Private Guide'),
(9, 'Container Gardenstay', NULL, 180, 'Whether you are instagramer, foodie, or just hopping around, Container Gardenstay is an unique staying experience for all kind of people.', 'Located at Taman Desa Tebrau, Container Gardenstay in the compound of the famous Thai Food Restaurant - Bangkok Village.\r\n\r\nContainer Gardenstay is built using several containers. We first saw this new hotel concept in foreign country and then we decided to bring this concept into Johor Bahru.\r\n\r\nEvery container room will have full facilities such as a bathroom, bathroom amenities, television, WiFi internet, big comfy bed, and also window view.\r\n\r\nWe also provide light breakfast for our hotel guest and also dinner for 2 at Bangkok Village restaurant (Only for departsoon''s buyer).\r\n\r\nBesides, Container Gardenstay is near to many hotspot or business area such as Aeon, Tesco, Johor Jaya.', NULL, 'https://www.departsoon.com/en/tour/12/container-gardenstay', 'Malaysia , Johor Bahru', 'English, Mandarin, Malay, Cantonese ', 'Lunch/Dinner(Pandan Chicken, Tom yum, Sambal Kangkong )', 'Personal Expenses', 'Homestay / Resort'),
(10, 'S Suites @ The Scott Garden', NULL, 240, 'Renovated in 2010, the S-Suites guarantees guests a pleasant stay whether in Kuala Lumpur for business or pleasure.\r\n', 'The Space\r\n\r\nIt is a 840sq feet duplex studio with 1 bedroom and 2 bathrooms.\r\n\r\nThe studio is warm and modern with everything you need to feel at home. It can comfortably accommodate 2 guests with 1 Queen Bed or 2 Single Bed.\r\n\r\nThe kitchen is well equipped with a microwave, cooking induction, hot water kettle, all the normal kitchen essentials and a refrigerator. The dinning table seats 4 comfortably.\r\n\r\nThe living room consists of a very huge L-shapes sofa, coffee table, a 32'''' flatscreen TV with multiple local channels and a big bookshelf. There are some information guide book for reference on everything guest need to know about the tourist attractions around Kuala Lumpur.\r\n\r\nThe only bedroom is located on the top floor which consists of a comfortable queen sized bed or two single beds. A nice designed and clean en-suite bathroom with heater shower are in the bedroom. Shower gel, hair shampoo, 2 towels and hair dryer are well prepared in the bedroom too.\r\n\r\nBesides, there is an indoor balcony area extended from the bedroom. Two comfortable chairs and a coffee table enable guests to enjoy the amazing skyline views (river view/ swimming pool view) while chatting with each other. Relax~!\r\n\r\nGuest Access\r\n\r\nA large infinity view swimming pool, kid pool, gymnasium room and children playground are located on 5th floor.\r\n\r\nAt Level 1, there are numbers of night clubs, restaurants, shops, laundry servies as well as CIMB bank and Tesco Store. It is a good place to hang out and chill with your friends and family.\r\n\r\nPrivate parking lots are located at Level 4A above Block B. Free parking per unit is available upon request.\r\n\r\nInteraction with Guests\r\n\r\nPlease be informed due to this property is an independently operated by individual owner therefore a session of ‘Meet & Greet'' for key handover and familiarization of the property will be arranged at our soho tower B lobby. (After building turn left , go up slope until the end then turn left and immediately on the right is soho tower B lobby.)\r\n', NULL, 'https://www.departsoon.com/en/tour/1/s-suites-the-scott-garden', 'Malaysia , Kuala Lumpur', 'English, Mandarin, Malay, Cantonese ', 'Cleaning Service  Housekeeping  Towel  Shampoo', 'Extra Bed', 'Homestay / Resort');

-- --------------------------------------------------------

--
-- Table structure for table `log_data`
--

CREATE TABLE IF NOT EXISTS `log_data` (
  `addressID` varchar(50) NOT NULL,
  `conversationID` varchar(50) NOT NULL,
  `userReply` varchar(255) NOT NULL,
  `botReply` varchar(9999) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `log_user`
--

CREATE TABLE IF NOT EXISTS `log_user` (
  `userID` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `conversationID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orderdetail`
--

CREATE TABLE IF NOT EXISTS `orderdetail` (
  `orderID` varchar(11) NOT NULL,
  `totalPrice` float NOT NULL,
  `travelDate` date NOT NULL,
  `tripduration` varchar(50) NOT NULL,
  `numberOfAdult` int(11) DEFAULT NULL,
  `numberOfChild` int(11) DEFAULT NULL,
  `numberOfInfant` int(11) DEFAULT NULL,
  `numberOfSeniorCitizen` int(11) DEFAULT NULL,
  `packageID` int(11) NOT NULL,
  `listingID` int(11) NOT NULL,
  `customerID` varchar(11) NOT NULL,
  `totalNumOfPeople` int(11) NOT NULL,
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orderdetail`
--

INSERT INTO `orderdetail` (`orderID`, `totalPrice`, `travelDate`, `tripduration`, `numberOfAdult`, `numberOfChild`, `numberOfInfant`, `numberOfSeniorCitizen`, `packageID`, `listingID`, `customerID`, `totalNumOfPeople`) VALUES
('001A', 72, '2016-07-26', '24 hours', NULL, NULL, NULL, NULL, 3, 3, '1', 6),
('001B', 192, '2016-07-27', '24 hours', 2, NULL, NULL, NULL, 13, 5, '2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE IF NOT EXISTS `package` (
  `packageID` int(4) NOT NULL,
  `packageTitle` varchar(50) NOT NULL,
  `packageDuration` varchar(50) NOT NULL,
  `rateID` int(4) NOT NULL,
  `listingID` int(4) NOT NULL,
  PRIMARY KEY (`packageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`packageID`, `packageTitle`, `packageDuration`, `rateID`, `listingID`) VALUES
(1, 'default', '1 day', 1, 1),
(2, 'default', '1 to 30 days', 2, 2),
(3, '4 Activities Package (min 6 pax)', '1 to 4 days', 3, 3),
(4, 'Abseiling (min 6 pax)', '', 4, 3),
(5, 'Flying Fox (min 6 pax)', '< 1 day', 4, 3),
(6, 'Rock Wall (min 6 pax)', '< 1 day', 4, 3),
(7, 'Paint Ball (min 6 pax)', '< 1 day', 5, 3),
(8, 'Kayaking (min 2 pax)', '< 1 day', 1, 3),
(9, 'Rain Forest Trek (min 6 pax)', '< 1 day', 6, 3),
(10, 'Rafting (min 8 pax)', '< 1 day', 7, 3),
(11, 'Indiana Jones (min 4 pax)', '< 1 day', 5, 3),
(12, 'default', '1 to 3 days', 8, 4),
(13, 'default', '1 to 30 days', 9, 5),
(14, 'Farm Visit + Pineapple Juice', '1 day', 10, 6),
(15, 'Farm Visit', '1 day', 11, 6),
(16, 'Small Tree House Daily Rate', '1 to 30 days', 12, 7),
(17, 'Tree House (2D1N)', '2 day', 13, 7),
(18, 'Tree House (3D2N)', '3 days', 17, 7),
(19, 'Tree House (4D3N)', '4 days', 18, 7),
(20, 'default', '1 day', 14, 8),
(21, 'default', '1 to 30 days', 15, 9),
(22, 'default', '1 to 30 days', 16, 10);

-- --------------------------------------------------------

--
-- Table structure for table `rate`
--

CREATE TABLE IF NOT EXISTS `rate` (
  `rateID` int(4) NOT NULL,
  `dailyRate` float DEFAULT NULL,
  `adultRate` float DEFAULT NULL,
  `childRate` float DEFAULT NULL,
  `infantRate` float DEFAULT NULL,
  `seniorCitizenRate` float DEFAULT NULL,
  PRIMARY KEY (`rateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rate`
--

INSERT INTO `rate` (`rateID`, `dailyRate`, `adultRate`, `childRate`, `infantRate`, `seniorCitizenRate`) VALUES
(1, 30, NULL, NULL, NULL, NULL),
(2, NULL, 45, 45, 0, 45),
(3, 72, NULL, NULL, NULL, NULL),
(4, 26, NULL, NULL, NULL, NULL),
(5, 20, NULL, NULL, NULL, NULL),
(6, 23, NULL, NULL, NULL, NULL),
(7, 26, NULL, NULL, NULL, NULL),
(8, 672, NULL, NULL, NULL, NULL),
(9, NULL, 96, 84, 0, 0),
(10, 18, NULL, NULL, NULL, NULL),
(11, 14, NULL, NULL, NULL, NULL),
(12, 260, NULL, NULL, NULL, NULL),
(13, NULL, 100, 60, 0, 100),
(14, NULL, 30, 25, 25, 31),
(15, 180, NULL, NULL, NULL, NULL),
(16, 240, NULL, NULL, NULL, NULL),
(17, NULL, 180, 100, 0, 180),
(18, NULL, 240, 140, 0, 240);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
