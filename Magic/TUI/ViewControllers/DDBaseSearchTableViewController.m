//
//  DDBaseSearchTableViewController.m
//  Wuya
//
//  Created by Tong on 05/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseSearchTableViewController.h"

@interface DDBaseSearchTableViewController ()

@end

@implementation DDBaseSearchTableViewController

#pragma mark -
#pragma mark Accessors
- (DDDataSource *)searchDataSource {
    if (nil == _searchDataSource) {
        _searchDataSource = [[DDDataSource alloc] init];
    }
    return _searchDataSource;
}

#pragma mark -
#pragma mark Content Filtering
- (void)filterContentForSearchText:(NSString*)searchText fromSearchButton:(BOOL)fromSearchButton {
    self.currentSearchText = searchText;
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], 44)];
    
    DDLog(@"%@", self.searchDisplayController);
    
    self.mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.mySearchDisplayController.delegate = self;
    self.mySearchDisplayController.searchResultsDelegate = self;
    self.mySearchDisplayController.searchBar.translucent = NO;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    
    self.tableView.tableHeaderView = self.searchBar; //this line add the searchBar
}


/** Data Source*/
- (DDBaseCellItem *)cellItemWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchDataSource cellItemForIndexPath:indexPath];
    }
    return [super cellItemWithIndexPath:indexPath tableView:tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchDataSource cellItemsCount];
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self cellItemWithIndexPath:indexPath tableView:tableView].cellHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


#pragma mark -
#pragma mark UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString fromSearchButton:NO];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    
    self.currentSearchText = nil;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    
}

@end
