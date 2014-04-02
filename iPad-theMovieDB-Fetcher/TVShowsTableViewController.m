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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Top Rated TV Shows";
    [self.view setBackgroundColor:BEIGE_COLOR];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    [self fetchShowsFeed];
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
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TVShowCell"];
    }
    NSDictionary *tvShow = self.tvShows[indexPath.row];
    
    // Display show info in the table cell
    cell.backgroundColor = BEIGE_COLOR;
    cell.textLabel.text = tvShow[@"original_name"];
    cell.detailTextLabel.text = tvShow[@"first_air_date"];
    NSURL *showThumbnailURL = [self imageURLWithSize:@"w92" andPath:tvShow[@"poster_path"]];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:showThumbnailURL]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *tvShow = self.tvShows[indexPath.row];
        NSURL *posterURL = [self imageURLWithSize:@"w780" andPath:tvShow[@"poster_path"]];
        
        TVShowViewController *tvShowVC = (TVShowViewController *)segue.destinationViewController;
        tvShowVC.title = tvShow[@"original_name"];
        tvShowVC.posterURL = posterURL;
        tvShowVC.showData = tvShow;
    }
}

#pragma mark - API & JSON Parsing

- (NSURL *)imageURLWithSize:(NSString *)size andPath:(NSString *)path {
    NSURL *imageURL = [NSURL URLWithString:
                       [NSString stringWithFormat:@"%@/t/p/%@%@", API_IMAGES_URL, size, path]];
    return imageURL;
}

- (void)fetchShowsFeed {
    NSString *options = @"language=en&include_image_language=en,null";
    NSURL *url = [[NSURL alloc] initWithString:
                  [NSString stringWithFormat:@"%@/3/tv/top_rated?api_key=%@&%@", API_ROOT_URL, THEMOVIEDB_API_KEY, options]];
    
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
