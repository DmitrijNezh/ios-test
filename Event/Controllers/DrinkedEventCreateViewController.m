//
//  DrinkedEventCreateViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrinkedEventCreateViewController.h"
#import "DrinkedEvent.h"

@implementation DrinkedEventCreateViewController

@synthesize beverage;

- (void)dealloc
{
    beverage = nil;
    [super dealloc];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    beverage = [[UITextField alloc] initWithFrame:CGRectMake(10, 110, 300, 40)];
    self.beverage.borderStyle = UITextBorderStyleRoundedRect;
    self.beverage.font = [UIFont systemFontOfSize:15];
    self.beverage.placeholder = @"beverage";
    [self.beverage setDelegate:self];
    [self.beverage addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.beverage.autocorrectionType = UITextAutocorrectionTypeNo;
    self.beverage.keyboardType = UIKeyboardTypeDefault;
    self.beverage.returnKeyType = UIReturnKeyDone;
    self.beverage.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.beverage.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
    
    [self.view addSubview:self.beverage];
    [self.beverage release];
}



#pragma mark - Misc

- (void)addEvent:(id)sender
{
    DrinkedEvent *drinkedEvent = [NSEntityDescription insertNewObjectForEntityForName:@"DrinkedEvent" inManagedObjectContext:self.managedObjectContext];
    [self fillTheFieldsOfEvent:drinkedEvent];
}

- (void)fillTheFieldsOfEvent:(Event *)event
{
    [(DrinkedEvent *)event setBeverage:self.beverage.text];
    [super fillTheFieldsOfEvent:event];
}

@end
