//
//  FriendsEventCreateViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendsEventCreateViewController.h"
#import "FriendsEvent.h"

@implementation FriendsEventCreateViewController

@synthesize friends;

- (void)dealloc
{
    friends = nil;
    [super dealloc];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    friends = [[UITextField alloc] initWithFrame:CGRectMake(10, 110, 300, 40)];
    self.friends.borderStyle = UITextBorderStyleRoundedRect;
    self.friends.font = [UIFont systemFontOfSize:15];
    self.friends.placeholder = @"friends exp. Bob, Ron, Max";
    [self.friends setDelegate:self];
    [self.friends addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.friends.autocorrectionType = UITextAutocorrectionTypeNo;
    self.friends.keyboardType = UIKeyboardTypeDefault;
    self.friends.returnKeyType = UIReturnKeyDone;
    self.friends.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.friends.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
    
    [self.view addSubview:self.friends];
    [self.friends release];
}



#pragma mark - Misc

- (void)addEvent:(id)sender
{
    FriendsEvent *friendsEvent = [NSEntityDescription insertNewObjectForEntityForName:@"FriendsEvent" inManagedObjectContext:self.managedObjectContext];
    [self fillTheFieldsOfEvent:friendsEvent];
}

- (void)fillTheFieldsOfEvent:(Event *)event
{
    [(FriendsEvent *)event setFriends:self.friends.text];
    [super fillTheFieldsOfEvent:event];
}

@end
