//
//  EventSearchViewController.h
//  BandsintownAPI
//
//  Created by Adam Cumiskey on 3/6/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventSearchViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
