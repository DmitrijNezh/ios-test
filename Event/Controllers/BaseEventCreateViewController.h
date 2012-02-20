//
//  BaseCreateEventViewController.h
//  Event
//
//  Created by Dima Nezhivoj on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface BaseEventCreateViewController : UIViewController

@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

- (void)addEvent:(id)sender;
- (void)fillTheFieldsOfEvent:(Event *)event;

@end
