//
//  Constant.h
//  SampleProject6
//
//  Created by Balagurubaran on 12/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#ifndef SampleProject6_Constant_h
#define SampleProject6_Constant_h

#define  PLAYERS @"PLAYERS"
#define  SERIES @"SERIES"
#define  BUDESLIGA @"Budesliga"

#define PLAYERSLIST @"PLAYERS,Novak Djokovic,Roger Federer,Rafael Nadal,Stan Wawrinka,Andy Murray,Kei Nishikori,Tomas Berdych,Marin Cilic,David Ferrer,Milos Raonic,Grigor Dimitrov,Jo Wilfried Tsongs,Ernests Gulbis,Fellciano Lopez,Roberto Bautista Agut,Tommy Robredo,Kevin Anderson,Gael Monfils"

#define SERIESLIST @"SEASON,Aus Open,Davis cup,Rotterdam,Rio De Janerio,Dubai,Acapulco,Indian Wells,Miami,Monte Carlo,Barcelona,Madrid,Rome,Roland Garros,Wimbledon,Hamburg,Washington,Toronto,Cincinnati,US Open,Beijing,Tokyo,Shanghai,Valencia,Basel,Paris,London,IPTL"

#define MORESETTINGS @[@"New",@"Most viewed",@"Highlights",@"Doubles",@"Singles",@"Records",@"Funny"];

#define LANGUAGE @"English,Spanish,German"

#define USERLIST_FILE @"selectedlist.json"
#define LANGUAGE_FILE @"language.json"

#define DEMO 0
#define IMAGEDATA @"imageData"
#define REQUESTID @"RequestID"
#define SOCIAL_ERROR_MESSAGE_TWITTER @"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
#define SOCIAL_ERROR_MESSAGE_FACEBOOK @"You can't send a post message into your wall right now, make sure your device has an internet connection and you have at least one Facebook account setup"

float screenWidthRation;
float screenHeightRation;
int updateMainView;

BOOL  loadNewVideo;
NSString *currentStoryBoard;

#define VIDEO_PER_PAGE_IPAD 6
#define VIDEO_PER_PAGE_IPHONE 6





#endif