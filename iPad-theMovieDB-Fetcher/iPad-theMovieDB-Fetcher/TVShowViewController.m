//
//  TVShowViewController.m
//  iPad-theMovieDB-Fetcher
//
//  Created by Aurélien Lemesle on 01/04/14.
//  Copyright (c) 2014 Aurélien Lemesle. All rights reserved.
//

#import "TVShowViewController.h"

@interface TVShowViewController ()

@property (nonatomic) NSURLSession *session;

@property (nonatomic, copy) NSDictionary *showDetails;

@end

@implementation TVShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:BEIGE_COLOR];

    [self.showPoster setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:self.posterURL]]];
    self.firstOnAirLabel.text = [NSString stringWithFormat:@"Show first appeared on: %@", self.showData[@"first_air_date"]];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    [self fetchTVShowDetails:self.showData[@"id"]];
}

#pragma mark - Show details request

- (NSString *)formatLabel:(NSString *)label withValue:(NSString *)value {
    if (value) {
        NSString *formatedString = [NSString stringWithFormat:@"%@ %@", label, value];
        return formatedString;
    }
    return @"";
}

- (void)fetchTVShowDetails:(NSString *)showID {
    NSURL *url = [[NSURL alloc] initWithString:
                  [NSString stringWithFormat:@"%@/3/tv/%@?api_key=%@", API_ROOT_URL, showID, THEMOVIEDB_API_KEY]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              self.showEpisodesLabel.text = [self formatLabel:self.showEpisodesLabel.text
                                                                                    withValue:jsonObject[@"number_of_episodes"]];
                                              self.showSeasonsLabel.text = [self formatLabel:self.showSeasonsLabel.text
                                                                                    withValue:jsonObject[@"number_of_seasons"]];
                                              self.showStatusLabel.text = [self formatLabel:self.showStatusLabel.text
                                                                                   withValue:jsonObject[@"status"]];
                                              self.showOverviewText.text = [self formatLabel:self.showOverviewText.text
                                                                                   withValue:jsonObject[@"overview"]];
                                          });
                                      }];
    [dataTask resume];
}

@end
