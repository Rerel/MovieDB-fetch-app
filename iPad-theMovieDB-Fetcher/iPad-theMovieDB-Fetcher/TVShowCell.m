//
//  TVShowCell.m
//  iPad-theMovieDB-Fetcher
//
//  Created by Aurélien Lemesle on 02/04/14.
//  Copyright (c) 2014 Aurélien Lemesle. All rights reserved.
//

#import "TVShowCell.h"

@implementation TVShowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
