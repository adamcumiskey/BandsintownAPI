//
//  EventSearchViewController.m
//  BandsintownAPI
//
//  Created by Adam Cumiskey on 3/6/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "EventSearchViewController.h"
#import "Bandsintown.h"

@interface EventSearchViewController ()
@property (strong, nonatomic) NSArray *events;
@end

@implementation EventSearchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _events = [NSArray array];
    [_searchBar setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    BITEvent *event = [_events objectAtIndex:indexPath.row];
    [cell.textLabel setText:event.title];
    [cell.detailTextLabel setText:event.location];
    
    BITArtist *artist = [[event artists] objectAtIndex:0];
    // In practice you would want to use image caching.
    // It isn't included in this example because of the overhead of adding another library to the project.
    [artist requestImageWithCompletionHandler:^(BOOL success, UIImage *artistImage, NSError *error) {
        if (success) {
            [cell.imageView setImage:artistImage];
            [cell setNeedsLayout];
        }
    }];
    
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    BITArtist *artist = [BITArtist artistNamed:searchBar.text];
    BITRequest *request = [BITRequest allEventsForArtist:artist];
    [BITRequestManager sendRequest:request
             withCompletionHandler:^(BOOL success, BITResponse *response, NSError *error) {
                 if (success) {
                     [self setEvents:response.events];
                     [self.tableView reloadData];
                 } else {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                     message:error.localizedDescription
                                                                    delegate:nil
                                                           cancelButtonTitle:@"Ok"
                                                           otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }];
}

@end
