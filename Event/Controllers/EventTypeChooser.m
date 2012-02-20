//
//  EventTypeChooser.m
//  Event
//
//  Created by Dima Nezhivoj on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventTypeChooser.h"
#import "BaseEventCreateViewController.h"
#import "EventTypes.h"

@implementation EventTypeChooser

@synthesize navigationController, managedObjectContext;



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[EventTypes instance] allEventNames] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[EventTypes instance] eventNameForID:[NSNumber numberWithInt:[indexPath row]]];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *className = [NSString stringWithFormat:@"%@CreateViewController", [[EventTypes instance] eventTypeForEventName:cell.textLabel.text]];
    BaseEventCreateViewController *createEvent = [[NSClassFromString(className) alloc] initWithNibName:@"BaseEventCreateViewController" bundle:nil];
    NSLog(@"%@",className);
    createEvent.managedObjectContext = self.managedObjectContext;
    createEvent.title = [[cell textLabel] text];
    createEvent.navigationController = self.navigationController;
    [self.navigationController pushViewController:createEvent animated:YES];
    [createEvent release];
}

@end
