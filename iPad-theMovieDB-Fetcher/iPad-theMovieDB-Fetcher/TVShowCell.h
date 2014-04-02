//
//  TVShowCell.h
//  iPad-theMovieDB-Fetcher
//
//  Created by Aurélien Lemesle on 02/04/14.
//  Copyright (c) 2014 Aurélien Lemesle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVShowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tvShowTitle;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UIImageView *tvShowThumbnail;

@end
