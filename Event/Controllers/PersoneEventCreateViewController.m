//
//  PersoneCreateEventViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PersoneEventCreateViewController.h"
#import "PersoneEvent.h"

@implementation PersoneEventCreateViewController

@synthesize name;

- (void)dealloc
{
    name = nil;
    [super dealloc];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    self.name.borderStyle = UITextBorderStyleRoundedRect;
    self.name.font = [UIFont systemFontOfSize:15];
    self.name.placeholder = @"name";
    [self.name setDelegate:self];
    [self.name addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.name.autocorrectionType = UITextAutocorrectionTypeNo;
    self.name.keyboardType = UIKeyboardTypeDefault;
    self.name.returnKeyType = UIReturnKeyDone;
    self.name.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    

    [self.view addSubview:self.name];
    [self.name release];
}



#pragma mark - Misc

- (void)addEvent:(id)sender
{
    PersoneEvent *bornEvent = [NSEntityDescription insertNewObjectForEntityForName:@"PersoneEvent" inManagedObjectContext:self.managedObjectContext];
    [self fillTheFieldsOfEvent:bornEvent];
}

- (void)fillTheFieldsOfEvent:(Event *)event
{
    [(PersoneEvent *)event setName:self.name.text];
    [super fillTheFieldsOfEvent:event];
}

- (IBAction)textFieldFinished:(id)sender
{
    // [sender resignFirstResponder];
}

@end
