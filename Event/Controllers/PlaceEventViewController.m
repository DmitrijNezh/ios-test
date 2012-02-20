//
//  PlaceEventViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlaceEventViewController.h"
#import "PlaceEvent.h"

@implementation PlaceEventViewController



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView] + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return @"Place";
    }
    return [super tableView:tableView titleForHeaderInSection:section];
}



#pragma mark - Misc

- (void)drawInCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    [super drawInCell:cell withIndexPath:indexPath];
    
    if (indexPath.section == 2) {
        cell.textLabel.text = [(PlaceEvent *)self.event place];
    }
    
}

@end
