//
//  DrinkedEventViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrinkedEventViewController.h"
#import "DrinkedEvent.h"

@implementation DrinkedEventViewController



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView] + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return @"Beverage";
    } 
    return [super tableView:tableView titleForHeaderInSection:section];
}



#pragma mark - Misc

- (void)drawInCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    [super drawInCell:cell withIndexPath:indexPath];
    
    if (indexPath.section == 3) {
        
        cell.textLabel.text = [(DrinkedEvent *)self.event beverage];
    }
    
}

@end
