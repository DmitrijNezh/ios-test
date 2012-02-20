//
//  EventsViewController.h
//  Event
//
//  Created by Dima Nezhivoj on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UITableViewController<UIAlertViewDelegate>

// Core Data
@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;

// UI
@property (nonatomic, assign) UINavigationController *navigationController;

// Events list from Core Data
@property (nonatomic, retain) NSMutableArray *events;

- (void)fetchRecords;

// Add button
- (void)addEvent:(id)sender;

@end
