//
//  defines.h
//  ObjectiveCLearning
//
//  Created by Aurélien Lemesle on 12/03/14.
//  Copyright (c) 2014 Aurélien Lemesle. All rights reserved.
//

#ifndef ObjectiveCLearning_defines_h
#define ObjectiveCLearning_defines_h

//
// TestFlight
//
#define TEST_FLIGHT_APP_TOKEN @""

//
// TheMovieDB API
//
#define API_ROOT_URL @"https://api.themoviedb.org"
#define API_IMAGES_URL @"http://image.tmdb.org"
#define THEMOVIEDB_API_KEY @"243dbca54d9de5d33857d3af894c9f0c"

//
// UI related
//
#define MAIN_FONT @""
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define HEIGHT_FOR_TEXT(text,width,margin,font) ([text sizeWithFont:font constrainedToSize:CGSizeMake(width-(margin*2),2000.0f) lineBreakMode:NSLineBreakByWordWrapping].height + margin*2)

//
// UI colors
//
#define BEIGE_COLOR [UIColor colorWithRed:0.96 green:0.95 blue:0.90 alpha:1.0]

//
// Application Information
//
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
#define APP_BUNDLE_IDENTIFIER [[NSBundle mainBundle] bundleIdentifier]

//
// Random utilities
//
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IPHONE_5() ([UIScreen mainScreen].bounds.size.height == 568.0f && [UIScreen mainScreen].scale == 2.f && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsEqual(x,y) ((x && [x isEqual:y]) || (!x && !y))


#endif
