//
//  BaseCreateEventViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseEventCreateViewController.h"
#import "EventTypes.h"

@implementation BaseEventCreateViewController

@synthesize navigationController, datePicker, managedObjectContext;

- (void)dealloc
{
    [datePicker release], datePicker = nil;
    [super dealloc];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent:)];  
    self.navigationItem.rightBarButtonItem = addButton;  
    [self.datePicker setDate:[NSDate date]];
    [addButton release];  
}



#pragma mark - Misc

- (void)addEvent:(id)sender
{
    Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    
    [self fillTheFieldsOfEvent:event];
}

- (void)fillTheFieldsOfEvent:(Event *)event
{
    [event setEventTypeID:[[EventTypes instance] eventIDForEventName:self.title]];
    [event setDate:self.datePicker.date];
    
    NSLog(@"des: %@", [event description]);
    
    BOOL notEmptyFields = [[event  description] rangeOfString:@"nil"].location == NSNotFound && [[event  description] rangeOfString:@"\"\""].location == NSNotFound;
    
    if (notEmptyFields) {
        NSError *error;  
        if( ! [managedObjectContext save:&error]) {  
            NSLog(@"Core data error: %@: ", error);
        } 
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.managedObjectContext deleteObject:event];
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Warning!"
                                                         message:@"Fill in all fields"
                                                        delegate:self
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil] autorelease];
        [alert show];
    }
}

@end
