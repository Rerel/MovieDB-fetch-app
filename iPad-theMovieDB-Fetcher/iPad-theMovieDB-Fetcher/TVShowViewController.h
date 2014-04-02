//
//  TVShowViewController.h
//  iPad-theMovieDB-Fetcher
//
//  Created by Aurélien Lemesle on 01/04/14.
//  Copyright (c) 2014 Aurélien Lemesle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVShowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *firstOnAirLabel;
@property (weak, nonatomic) IBOutlet UILabel *showEpisodesLabel;
@property (weak, nonatomic) IBOutlet UILabel *showSeasonsLabel;
@property (weak, nonatomic) IBOutlet UILabel *showStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showPoster;
@property (weak, nonatomic) IBOutlet UITextView *showOverviewText;

@property (nonatomic, copy) NSURL *posterURL;
@property (nonatomic, copy) NSDictionary *showData;

@end
