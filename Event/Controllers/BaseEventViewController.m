//
//  BaseModalViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseEventViewController.h"

@implementation BaseEventViewController

@synthesize event;



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [self drawInCell:cell withIndexPath:indexPath];
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Date";
    }
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - Misc

- (void)drawInCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    static NSDateFormatter *dateFormatter = nil;   
    
    if (dateFormatter == nil) {  
        dateFormatter = [[NSDateFormatter alloc] init];  
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];  
    } 

    if (indexPath.section == 0) {
        cell.textLabel.text = [dateFormatter stringFromDate:[self.event date]];
    }
}

@end
