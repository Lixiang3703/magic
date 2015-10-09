//
//  YYBaseSearchTableViewController.h
//  Wuya
//
//  Created by Tong on 06/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYBaseTableViewController.h"
#import "YYSearchBar.h"

@interface YYBaseSearchTableViewController : YYBaseTableViewController

/** Search */
@property (nonatomic, strong) DDDataSource *searchDataSource;
@property (nonatomic, assign) BOOL searchBarModeEnabled;
@property (nonatomic, copy) NSString *currentSearchText;
@property (nonatomic, strong) UISearchDisplayController *mySearchDisplayController;
@property (nonatomic, strong) YYSearchBar *searchBar;

- (void)filterContentForSearchText:(NSString*)searchText fromSearchButton:(BOOL)fromSearchButton;


/** Search Bar */
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller;
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller;
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller;
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller;

@end
