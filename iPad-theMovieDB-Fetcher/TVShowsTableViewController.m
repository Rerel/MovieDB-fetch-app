//
//  TVShowsTableViewController.m
//  iPad-theMovieDB-Fetcher
//
//  Created by Aurélien Lemesle on 01/04/14.
//  Copyright (c) 2014 Aurélien Lemesle. All rights reserved.
//

#import "TVShowViewController.h"
#import "TVShowsTableViewController.h"

@interface TVShowsTableViewController ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *tvShows;

@end

@implementation TVShowsTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Top Rated TV Shows";
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];

        [self fetchShowsFeed];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TVShowCell"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tvShows count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVShowCell" forIndexPath:indexPath];
    
    NSDictionary *tvShow = self.tvShows[indexPath.row];
    
    // Display show info in the table cell
    cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.90 alpha:1.0];    
    cell.textLabel.text = tvShow[@"original_name"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tvShow = self.tvShows[indexPath.row];
}

#pragma mark - API & JSON Parsing

- (NSURL *)imageURLWithSize:(NSString *)size andPath:(NSString *)path {
    NSURL *imageURL = [NSURL URLWithString:
                       [NSString stringWithFormat:@"http://image.tmdb.org/t/p/%@%@", size, path]];
    return imageURL;
}

- (void)fetchShowsFeed {
    NSString *rootURL = @"https://api.themoviedb.org";
    NSString *apiKey = @"243dbca54d9de5d33857d3af894c9f0c";
    NSString *options = @"language=en&include_image_language=en,null";
    NSURL *url = [[NSURL alloc] initWithString:
                  [NSString stringWithFormat:@"%@/3/tv/top_rated?api_key=%@&%@", rootURL, apiKey, options]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          self.tvShows = jsonObject[@"results"];
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.tableView reloadData];
                                          });
                                      }];
    [dataTask resume];
}


@end
