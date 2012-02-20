//
//  PlaceEventCreateViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlaceEventCreateViewController.h"
#import "PlaceEvent.h"

@implementation PlaceEventCreateViewController

@synthesize place;

- (void)dealloc
{
    place = nil;
    [super dealloc];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    place = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 40)];
    self.place.borderStyle = UITextBorderStyleRoundedRect;
    self.place.font = [UIFont systemFontOfSize:15];
    self.place.placeholder = @"place";
    [self.place setDelegate:self];
    [self.place addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.place.autocorrectionType = UITextAutocorrectionTypeNo;
    self.place.keyboardType = UIKeyboardTypeDefault;
    self.place.returnKeyType = UIReturnKeyDone;
    self.place.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.place.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
    
    [self.view addSubview:self.place];
    [self.place release];
}



#pragma mark - Misc

- (void)addEvent:(id)sender
{
    PlaceEvent *placeEvent = [NSEntityDescription insertNewObjectForEntityForName:@"PlaceEvent" inManagedObjectContext:self.managedObjectContext];
    [self fillTheFieldsOfEvent:placeEvent];
}

- (void)fillTheFieldsOfEvent:(Event *)event
{
    [(PlaceEvent *)event setPlace:self.place.text];
    [super fillTheFieldsOfEvent:event];
}

@end
