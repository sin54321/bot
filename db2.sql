USE [master]
GO
/****** Object:  Database [bot_database]    Script Date: 7/25/2016 3:08:29 PM ******/
CREATE DATABASE [bot_database]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bot_database', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\bot_database.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'bot_database_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\bot_database_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [bot_database] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bot_database].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bot_database] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bot_database] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bot_database] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bot_database] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bot_database] SET ARITHABORT OFF 
GO
ALTER DATABASE [bot_database] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [bot_database] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bot_database] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bot_database] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bot_database] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bot_database] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bot_database] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bot_database] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bot_database] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bot_database] SET  ENABLE_BROKER 
GO
ALTER DATABASE [bot_database] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bot_database] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bot_database] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bot_database] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bot_database] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bot_database] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bot_database] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bot_database] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [bot_database] SET  MULTI_USER 
GO
ALTER DATABASE [bot_database] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bot_database] SET DB_CHAINING OFF 
GO
ALTER DATABASE [bot_database] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [bot_database] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [bot_database] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [bot_database] SET QUERY_STORE = OFF
GO
USE [bot_database]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [bot_database]
GO
/****** Object:  User [root]    Script Date: 7/25/2016 3:08:30 PM ******/
CREATE USER [root] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 7/25/2016 3:08:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[customerID] [int] NOT NULL,
	[emailAddress] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[gender] [varchar](50) NULL,
	[birthDate] [date] NULL,
	[phoneNum] [varchar](50) NULL,
	[address] [varchar](max) NULL,
	[description] [varchar](max) NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[faq]    Script Date: 7/25/2016 3:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[faq](
	[id] [int] NOT NULL,
	[question] [varchar](999) NOT NULL,
	[answer] [varchar](999) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[modified_date] [datetime] NOT NULL,
	[qkey] [varchar](999) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[listing]    Script Date: 7/25/2016 3:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[listing](
	[id] [int] NOT NULL,
	[header] [varchar](999) NOT NULL,
	[location] [varchar](255) NOT NULL,
	[duration] [varchar](255) NOT NULL,
	[language] [varchar](255) NOT NULL,
	[price] [float] NOT NULL,
	[introduction] [varchar](999) NOT NULL,
	[experience] [varchar](8000) NOT NULL,
	[included] [varchar](999) NOT NULL,
	[reminder] [varchar](999) NOT NULL,
	[link] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[orderDetail]    Script Date: 7/25/2016 3:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderDetail](
	[orderID] [varchar](50) NOT NULL,
	[totalPrice] [float] NOT NULL,
	[numberOfAdult] [int] NULL,
	[numberOfChild] [int] NULL,
	[numberOfInfant] [int] NULL,
	[numberOfSeniorCitizen] [int] NULL,
	[packageID] [int] NOT NULL,
	[listingID] [int] NOT NULL,
	[customerID] [int] NOT NULL,
	[travelDate] [date] NOT NULL,
	[totalNumOfPeople] [int] NULL,
	[duration] [varchar](50) NULL,
 CONSTRAINT [PK_orderDetail] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[package]    Script Date: 7/25/2016 3:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[package](
	[packageID] [int] NOT NULL,
	[packageTitle] [varchar](50) NOT NULL,
	[packageDuration] [varchar](50) NULL,
	[rateID] [int] NOT NULL,
	[listingID] [int] NULL,
 CONSTRAINT [PK_package] PRIMARY KEY CLUSTERED 
(
	[packageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rate]    Script Date: 7/25/2016 3:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rate](
	[rateID] [int] NOT NULL,
	[dailyRate] [float] NULL,
	[adultRate] [float] NULL,
	[childRate] [float] NULL,
	[infantRate] [float] NULL,
	[seniorCitizenRate] [float] NULL,
 CONSTRAINT [PK_rate] PRIMARY KEY CLUSTERED 
(
	[rateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[customer] ([customerID], [emailAddress], [password], [firstName], [lastName], [gender], [birthDate], [phoneNum], [address], [description]) VALUES (1, N'naijun@hotmail.com', N'123456', N'Pong', N'Nai Jun', N'M', CAST(N'2016-01-01' AS Date), N'0123456789', N'Taman bunga', N'I love trips')
INSERT [dbo].[customer] ([customerID], [emailAddress], [password], [firstName], [lastName], [gender], [birthDate], [phoneNum], [address], [description]) VALUES (2, N'calvin@yahoo.com', N'654321', N'Calvin S''ng', N'Kai Vee', N'M', CAST(N'2016-01-01' AS Date), N'0193456789', N'Taman matahari', N'Trip is life')
INSERT [dbo].[customer] ([customerID], [emailAddress], [password], [firstName], [lastName], [gender], [birthDate], [phoneNum], [address], [description]) VALUES (3, N'rose@aol.com', N'987654', N'Rose', N'Maria', N'F', CAST(N'2016-01-01' AS Date), N'0183456789', N'Taman air', N'Trip is belief')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (1, N'How can I purchase packages/services on this website?', N'First, you will need to register as a user. Login to your account, choose a tour, select the “book” button and follow the instructions.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'how, purchase, buy, website ,packages, services, trips')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (2, N'When will I be charged for the payment?', N'After you make a request, we will prompt the seller/tour operator to confirm the request. Upon his/her confirmation, the transaction will be made. But you can amend/cancel your booking at any time before that happens.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'charged,charge,payment,money,credit,when,bill')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (3, N'When and how do I know that the order is confirmed?', N'After the seller/tour operator confirms your request, your booking status will be updated. You will also receive a confirmation email.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'when,how,order,confirmed,confirm,know')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (4, N'Can I change my order after the payment is made?', N'After the payment is made, the order cannot be changed, i.e., adding more tour members or requesting a different starting time. But you can still cancel the order, see below.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'change,order,payment,made,make,changed,paid,can,after')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (5, N'Can I cancel the order and receive a refund?', N'Yes, you can cancel the order. Depending on the refund policy, a complete/partial refund can be made. See refund policy for details.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'cancel,refund,cancellation,money,back,can')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (6, N'How do I communicate with the seller?', N'After a tour is confirmed by both parties, you can contact the seller through the messenger service.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'communicate,seller,talk,message,provider,how')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (7, N'What if the seller/tour guides don’t show up?', N'You should contact us as soon as possible. Since we will hold the transaction before the tour is completed, upon verification, we will proceed by returning a full refund to you.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'seller,tour,guide,show,up,disappear,gone,missing,what')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (8, N'How do I review the package/services?', N'After you complete the tour, an email will be sent to your email account. You can make your comments/reviews through a link in the email.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'review,packages,services,comments,how')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (9, N'What are the requirements for user to sign up as seller/tour operator on departsoon.com?', N'There is no specifc requirement to register as seller/tour operator at www.departsoon.com. We welcome you to sign up as long as you have the passion in sharing the local culture with people around the globe, including but not limited to providing private tour guiding service, transportation service, ticketing service, accommodation and others.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'requirements,sign,up,seller,tour,guides,register,operator,what')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (10, N'When can a signed up seller/tour operator start to sell their listing?', N'You can start to sell your listing once your account has been verified.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'signed,up,seller,tour,guides,listing,when,operator,start,when')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (11, N'When seller/tour operator get their payment?', N'There will be a grace period for 3 working days after the tour ended. The payment will be issued to seller/ tour operator on the following Wednesday after the grace period.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'when,seller,tour,guides,get,payment,paid,money,receive,operator')
INSERT [dbo].[faq] ([id], [question], [answer], [created_date], [modified_date], [qkey]) VALUES (12, N'How Departsoon pay out to sell/tour operator?', N'Departsoon will issue the payment to seller/tour operator via telegraphic transfer to their selected bank account.', CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-10T00:00:00.000' AS DateTime), N'pay,out,seller,tour,guides,payment,issue,departsoon,how,operator')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (1, N'World Class Classical Guitarist Samuel Klemke live in Pontian', N'Malaysia , Pekan Nenas', N'2 hours', N'Mandarin ', 30, N'World Class Classical Guitarist Samuel Klemke live in Pontian, Johor', N'World class classical guitarist from Germany, for the first time, visit Johor to perform a tour concerts, and he is coming to Pontian, Johor to perform the aforesaid concert on 17th of June, 2015 venue as below:

Venue: 笨珍培群独立中学李织霞讲堂
Time: 8pm ', N'concert', N'', N'https://www.departsoon.com/en/tour/24/world-class-classical-guitarist-samuel-klemke-live-in-pontian')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (2, N'Kulai Rainforest 1 Day Experience Tour', N'Malaysia , Kulai, Johor Bahru', N'8 hours ', N'English, Mandarin, Cantonese ', 45, N'Ever tried or fancy to sleep in a tree house? At Kulai Rainforest Tree House you will enjoy everything nature has to offer.', N'At Kulai Rainforest Tree House, all our treehouses are built in a very environmentally friendly way.

We used natural material from the forest to build treehouses. All small trunks are well preserved.

Each treehouse is unique because they are built according to the hill contour and position of the tree trunks.

Each treehouse has all the basic of a house, toilet, bathroom, ladder, bed, mosquito net, window, and also electricity with minimal lighting and fan. No aircon, though. But hey, who still needs aircon in the forest.

Treehouse aside, you can also participate in activities such as jungle trekking, waterfall, and some learning sessions.

At night, you will join every guest of the night at the pavilion hall for dinner and listen to the briefing by the owner.

Activity included :
Briefing of tree house concept (natural building ,organic farming etc )
Guide to jungle walk and waterfall.

Check in at about 2pm and check out at about 12 pm. (Can still stay at our hall and play at river after u check out)

Details of the room:
4 small tree house {Small tree house can fix 6 pax for (max)} ;
2 big tree house {Big tree house can fix 12 pax (max).}

10 minutes mountain walking distance to the first tree house (about 300 stair steps),

Amenities include:
power plug, mosquito net, blanket, cotton pillow, comfortable mattress bathroom with cold stream water shower and toilet bowl.


Things to bring:
Water bottle, backpack, clothes (long pants to avoid insect), towel, toiletries, insect
repellent, umbrella (for back up use)', N'Lunch
Green Bean Soup', N'Minimum 20 people in order to fullfill this trip.
In the event if participant is less than 20 people, the tour will be cancelled, a cancellation E-mail notification will be sent 7 days before departure.
', N'https://www.departsoon.com/en/tour/23/kulai-rainforest-1-day-experience-tour')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (3, N'Kota Rainforest Resort Outdoor Activities', N'Malaysia , Kota Tinggi', N'', N'English, Malay, Mandarin', 19, N'Kota Rainforest Resort provide all ranges of outdoor activities. Come here to join activities with beautiful rainforest surrounding you.
', N'Choose any 4 activities from:
Abseiling (min 6 pax)
Flying Fox (min 6 pax)
Rock Wall (min 6 pax)
Paint Ball(target shooting) (min 4 pax)
Kayaking (min 2 pax)
Rainforest Trek (min 6 pax)
Rafting (min 8 pax)
Indiana Jones (min 4 pax)
', N'Entrance fee for activities only', N'', N'https://www.departsoon.com/en/tour/22/kota-rainforest-resort-outdoor-activities')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (4, N'Kota Rainforest Resort & Activities', N'Malaysia , Kota Tinggi', N' 2 days  ', N'English, Mandarin, Malay, Cantonese ', 672, N'At Kota Rainforest Resort you will be amazed by the surrounding rainforest and the range of activities we provide.', N'Need a quick getaway? Kota Rainforest Resort at Johor''s Kota Tinggi may be your best choice.

This place is so hideous that usually not many car passes by. And with all the rainforest surrounding the resort, you will surely have a relaxing getaway at Kota Rainforest Resort.

Besides, we will bring you to the famous Kota Tinggi Waterfall which is just few minutes away from our resort.

Secondly, we will take you to Kota Tinggi Firefly Park. You will be riding on a boat and enjoy the beautiful scenic.
', N'Quad Sharing Room
Breakfast
Dinner
Waterfall Tour
Accommodation
Paintball (target shooting)
Kayaking', N'', N'https://www.departsoon.com/en/tour/21/kota-rainforest-resort-activities')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (5, N'Claycup making at Platform Coffee & Homestay', N'Malaysia , Pekan Nenas, Johor Bahru', N'1 day', N'English, Mandarin, Malay, Cantonese ', 96, N'Recharge yourself in this peace and quient small town. Plus you get to learn how to hand made a ceramic cup!', N'Platform Coffee & Homestay is neither your ordinary coffee cafe nor usual new village homestay.

Our motto for Platform Coffee & Homestay is to provide everyone a "platform" to rest their mind and recharge themselves, before going back to their busy life.

Besides providing great coffee beverage and good night sleep, we thought there are more ways to release stress. Hand-making ceramic cup may be a good idea.

At Platform Coffee & Homestay we provide learning session for newbie to learn the process of ceramic cup making. At the end of the process, you may bring your cup back home or leave it here and use it during your visit.

Come and explore us more!', N'Porcelain cup learning session', N'', N'https://www.departsoon.com/en/tour/17/claycup-making-at-platform-coffee-homestay')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (6, N'Nictar Symbiosis Farm Tour', N'Malaysia , Pekan Nenas, Kuala Lumpur', N'2 hours', N'English, Mandarin, Malay, Cantonese ', 14, N'At Nictar Symbiosis Farm, you are not just seeing the pineapple farm, you will see how different living creatures grow and live together.', N'Nictar Symbiosis Farm is located in Pontian''s Parit Sikom.

In short, symbiosis means different living organisms grow together at the same location.

Our farm has a total area of 10 acres. We have grow several species of pineapple, bees, chicken, and some dogs to guard our farm! And best of all, they all coexist in the farm and bring benefits to one another.

Come here to learn the concept of symbiosis and knowledge of pineapple. You will love eating pineapple again after this tour.', N'Pineapple juice
Farm Tour', N'Minimum 10 people in order to fullfill this trip.
In the event if participant is less than 10 people, the tour will be cancelled, a cancellation E-mail notification will be sent 1 days before departure.

In the event of typhoons, storms and other poor weather, we will determine whether we will cancel the tour 0 day before departure at local time 9:00 and notify customer via Email.', N'https://www.departsoon.com/en/tour/16/nictar-symbiosis-farm-tour')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (7, N'Kulai Rainforest Tree House Stay And Activities', N'Malaysia , Kulai', N'2 days  ', N'English, Mandarin, Malay, Cantonese ', 260, N'Ever tried or fancy to sleep in a tree house? At Kulai Rainforest Tree House you will enjoy everything nature has to offer.', N'At Kulai Rainforest Tree House, all our treehouses are built in a very environmentally friendly way.

We used natural material from the forest to build treehouses. All small trunks are well preserved.

Each treehouse is unique because they are built according to the hill contour and position of the tree trunks.

Each treehouse has all the basic of a house, toilet, bathroom, ladder, bed, mosquito net, window, and also electricity with minimal lighting and fan. No aircon, though. But hey, who still needs aircon in the forest.

Treehouse aside, you can also participate in activities such as jungle trekking, waterfall, and some learning sessions.

At night, you will join every guest of the night at the pavilion hall for dinner and listen to the briefing by the owner.

Activity included :
Briefing of tree house concept (natural building ,organic farming etc )
Guide to jungle walk and waterfall.

Check in at about 2pm and check out at about 12 pm. (Can still stay at our hall and play at river after u check out)

Details of the room:
4 small tree house {Small tree house can fix 6 pax for (max)} ;
2 big tree house {Big tree house can fix 12 pax (max).}

10 minutes mountain walking distance to the first tree house (about 300 stair steps),

Amenities include:
power plug, mosquito net, blanket, cotton pillow, comfortable mattress bathroom with cold stream water shower and toilet bowl.


Things to bring:
Water bottle, backpack, clothes (long pants to avoid insect), towel, toiletries, insect
repellent, umbrella (for back up use)', N'Jungle trekking
Guide to Waterfall
1 Dinner (simple vege steamboat) 1 breakfast (nasi lemak) for 2Days 1Night
2dinner ,2breakfast ,1lunch for 3Days 2Nights', N'', N'https://www.departsoon.com/en/tour/15/kulai-rainforest-tree-house-stay-and-activities')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (8, N'Glow in dark 3D art', N'Malaysia , Johor Bahru', N'2 hours  ', N'English, Mandarin, Malay, Cantonese	', 25, N'Ever seen 3D art glowing in the dark? At Dark Art 3D Studio you will get to see what we called as "2-in-1 3D art".', N'Dark Art 3D Studio is not your usual 3D art gallery.

At Dart Art 3D Studio, every art has 2 presentations.

The very same art will look differently in different lighting condition.

Visitors can take a photo with the 3D poster under normal fluorescent lighting. When the light turned off, the art will be glowing in the dark and different layer will appear.

Come and take some creative photo with your wildest imagination.', N'Entrance', N'', N'https://www.departsoon.com/en/tour/14/glow-in-dark-3d-art')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (9, N'Container Gardenstay', N'Malaysia , Johor Bahru', N'', N'English, Mandarin, Malay, Cantonese ', 180, N'Whether you are instagramer, foodie, or just hopping around, Container Gardenstay is an unique staying experience for all kind of people.', N'Located at Taman Desa Tebrau, Container Gardenstay in the compound of the famous Thai Food Restaurant - Bangkok Village.

Container Gardenstay is built using several containers. We first saw this new hotel concept in foreign country and then we decided to bring this concept into Johor Bahru.

Every container room will have full facilities such as a bathroom, bathroom amenities, television, WiFi internet, big comfy bed, and also window view.

We also provide light breakfast for our hotel guest and also dinner for 2 at Bangkok Village restaurant (Only for departsoon''s buyer).

Besides, Container Gardenstay is near to many hotspot or business area such as Aeon, Tesco, Johor Jaya.', N'Lunch/Dinner(Pandan Chicken, Tom yum, Sambal Kangkong )', N'', N'https://www.departsoon.com/en/tour/12/container-gardenstay')
INSERT [dbo].[listing] ([id], [header], [location], [duration], [language], [price], [introduction], [experience], [included], [reminder], [link]) VALUES (10, N'S Suites @ The Scott Garden', N'Malaysia , Kuala Lumpur', N'', N'English, Mandarin, Malay, Cantonese ', 240, N'Renovated in 2010, the S-Suites guarantees guests a pleasant stay whether in Kuala Lumpur for business or pleasure.', N'The Space

It is a 840sq feet duplex studio with 1 bedroom and 2 bathrooms.

The studio is warm and modern with everything you need to feel at home. It can comfortably accommodate 2 guests with 1 Queen Bed or 2 Single Bed.

The kitchen is well equipped with a microwave, cooking induction, hot water kettle, all the normal kitchen essentials and a refrigerator. The dinning table seats 4 comfortably.

The living room consists of a very huge L-shapes sofa, coffee table, a 32'' flatscreen TV with multiple local channels and a big bookshelf. There are some information guide book for reference on everything guest need to know about the tourist attractions around Kuala Lumpur.

The only bedroom is located on the top floor which consists of a comfortable queen sized bed or two single beds. A nice designed and clean en-suite bathroom with heater shower are in the bedroom. Shower gel, hair shampoo, 2 towels and hair dryer are well prepared in the bedroom too.

Besides, there is an indoor balcony area extended from the bedroom. Two comfortable chairs and a coffee table enable guests to enjoy the amazing skyline views (river view/ swimming pool view) while chatting with each other. Relax~!

Guest Access

A large infinity view swimming pool, kid pool, gymnasium room and children playground are located on 5th floor.

At Level 1, there are numbers of night clubs, restaurants, shops, laundry servies as well as CIMB bank and Tesco Store. It is a good place to hang out and chill with your friends and family.

Private parking lots are located at Level 4A above Block B. Free parking per unit is available upon request.

Interaction with Guests

Please be informed due to this property is an independently operated by individual owner therefore a session of ‘Meet & Greet'' for key handover and familiarization of the property will be arranged at our soho tower B lobby. (After building turn left , go up slope until the end then turn left and immediately on the right is soho tower B lobby.)
', N'Cleaning Service
Housekeeping
Towel
Shampoo', N'', N'https://www.departsoon.com/en/tour/1/s-suites-the-scott-garden')
INSERT [dbo].[orderDetail] ([orderID], [totalPrice], [numberOfAdult], [numberOfChild], [numberOfInfant], [numberOfSeniorCitizen], [packageID], [listingID], [customerID], [travelDate], [totalNumOfPeople], [duration]) VALUES (N'001A', 72, NULL, NULL, NULL, NULL, 3, 3, 1, CAST(N'2016-07-26' AS Date), 6, N'1 day')
INSERT [dbo].[orderDetail] ([orderID], [totalPrice], [numberOfAdult], [numberOfChild], [numberOfInfant], [numberOfSeniorCitizen], [packageID], [listingID], [customerID], [travelDate], [totalNumOfPeople], [duration]) VALUES (N'003C', 192, 2, NULL, NULL, NULL, 13, 5, 2, CAST(N'2016-07-27' AS Date), 2, N'1 day')
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (1, N'default', N'1 day', 1, 1)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (2, N'default', N'1 to 30 days', 2, 2)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (3, N'4 Activities Package (min 6 pax)', N'1 to 4 days', 3, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (4, N'Abseiling (min 6 pax)', N'', 4, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (5, N'Flying Fox (min 6 pax)', N'< 1 day', 4, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (6, N'Rock Wall (min 6 pax)', N'< 1 day', 4, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (7, N'Paint Ball (min 6 pax)', N'< 1 day', 5, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (8, N'Kayaking (min 2 pax)', N'< 1 day', 1, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (9, N'Rain Forest Trek (min 6 pax)', N'< 1 day', 6, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (10, N'Rafting (min 8 pax)', N'< 1 day', 7, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (11, N'Indiana Jones (min 4 pax)', N'< 1 day', 5, 3)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (12, N'default', N'1 to 3 days', 8, 4)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (13, N'default', N'1 to 30 days', 9, 5)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (14, N'Farm Visit + Pineapple Juice', N'1 day', 10, 6)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (15, N'Farm Visit', N'1 day', 11, 6)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (16, N'Small Tree House Daily Rate', N'1 to 30 days', 12, 7)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (17, N'Tree House (2D1N)', N'2 day', 13, 7)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (18, N'Tree House (3D2N)', N'3 days', 17, 7)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (19, N'Tree House (4D3N)', N'4 days', 18, 7)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (20, N'default', N'1 day', 14, 8)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (21, N'default', N'1 to 30 days', 15, 9)
INSERT [dbo].[package] ([packageID], [packageTitle], [packageDuration], [rateID], [listingID]) VALUES (22, N'default', N'1 to 30 days', 16, 10)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (1, 30, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (2, NULL, 45, 35, 0, 45)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (3, 72, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (4, 26, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (5, 20, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (6, 23, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (7, 26, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (8, 672, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (9, NULL, 96, 84, 0, 0)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (10, 18, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (11, 14, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (12, 260, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (13, NULL, 100, 60, 0, 100)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (14, NULL, 30, 25, 25, 31)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (15, 180, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (16, 240, NULL, NULL, NULL, NULL)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (17, NULL, 180, 100, 0, 180)
INSERT [dbo].[rate] ([rateID], [dailyRate], [adultRate], [childRate], [infantRate], [seniorCitizenRate]) VALUES (18, NULL, 240, 140, 0, 240)
ALTER TABLE [dbo].[orderDetail]  WITH CHECK ADD  CONSTRAINT [FK_orderDetail_customer] FOREIGN KEY([customerID])
REFERENCES [dbo].[customer] ([customerID])
GO
ALTER TABLE [dbo].[orderDetail] CHECK CONSTRAINT [FK_orderDetail_customer]
GO
ALTER TABLE [dbo].[orderDetail]  WITH CHECK ADD  CONSTRAINT [FK_orderDetail_listing] FOREIGN KEY([listingID])
REFERENCES [dbo].[listing] ([id])
GO
ALTER TABLE [dbo].[orderDetail] CHECK CONSTRAINT [FK_orderDetail_listing]
GO
ALTER TABLE [dbo].[orderDetail]  WITH CHECK ADD  CONSTRAINT [FK_orderDetail_package] FOREIGN KEY([packageID])
REFERENCES [dbo].[package] ([packageID])
GO
ALTER TABLE [dbo].[orderDetail] CHECK CONSTRAINT [FK_orderDetail_package]
GO
ALTER TABLE [dbo].[package]  WITH CHECK ADD  CONSTRAINT [FK_package_package] FOREIGN KEY([packageID])
REFERENCES [dbo].[package] ([packageID])
GO
ALTER TABLE [dbo].[package] CHECK CONSTRAINT [FK_package_package]
GO
ALTER TABLE [dbo].[rate]  WITH CHECK ADD  CONSTRAINT [FK_rate_package] FOREIGN KEY([rateID])
REFERENCES [dbo].[package] ([packageID])
GO
ALTER TABLE [dbo].[rate] CHECK CONSTRAINT [FK_rate_package]
GO
USE [master]
GO
ALTER DATABASE [bot_database] SET  READ_WRITE 
GO
