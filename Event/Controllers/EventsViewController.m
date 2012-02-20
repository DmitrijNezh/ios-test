//
//  BaseTableViewController.m
//  Event
//
//  Created by Dima Nezhivoj on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventsViewController.h"
#import "BaseEventViewController.h"
#import "EventTypeChooser.h"
#import "Event.h"
#import "EventTypes.h"

@interface EventsViewController ()

// Handle cell for Delete Alert
@property (nonatomic, retain) NSIndexPath *currentCellIndexPath;

@end



@implementation EventsViewController

@synthesize events, managedObjectContext, currentCellIndexPath, navigationController;

- (void)dealloc
{
    [events release], events = nil;
    [currentCellIndexPath release], currentCellIndexPath = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        events = [[NSMutableArray alloc] init];
        currentCellIndexPath = [[NSIndexPath alloc] init];
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent:)];  
    self.navigationItem.rightBarButtonItem = addButton;  
    [addButton release];  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchRecords];
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    static NSDateFormatter *dateFormatter = nil;   
    
    if (dateFormatter == nil) {  
        dateFormatter = [[NSDateFormatter alloc] init];  
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];  
    }  
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        
        // Long press on cell
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longCellPress:)];
        [longPress setMinimumPressDuration:1.2]; // triggers the action after 2 seconds of press
        [cell addGestureRecognizer:longPress];
        [longPress release];
    }
    
    Event *event = [self.events objectAtIndex:[indexPath row]];  
    
    [cell.textLabel setText:[[EventTypes instance] eventNameForID:[event eventTypeID]]]; 
    [cell.detailTextLabel setText:[dateFormatter stringFromDate:[event date]]];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *event = [self.events objectAtIndex:[indexPath row]];

    NSString *className = [NSString stringWithFormat:@"%@ViewController", [[EventTypes instance] eventTypeForID:[event eventTypeID]]]; 
    NSLog(@"%@",className);
    BaseEventViewController *showView = [[NSClassFromString(className) alloc] initWithNibName:@"BaseEventViewController" bundle:nil];
    showView.event = event;
    showView.title = [[EventTypes instance] eventNameForID:[event eventTypeID]];
    [self.navigationController pushViewController:showView animated:YES];
    [showView release];
}



#pragma mark - Alert View delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Yes"]) {
        [self.managedObjectContext deleteObject:(Event *)[self.events objectAtIndex:self.currentCellIndexPath.row]];
        [self.events removeObjectAtIndex:self.currentCellIndexPath.row];
        
        NSError *error;  
        if( ! [managedObjectContext save:&error]) {  
            NSLog(@"Core data error: %@ ", error);
        }  
        
        [self.tableView reloadData];
    }
}



#pragma mark - Fetch

- (void)fetchRecords {   
    
    // Define our table/entity to use  
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];   
    
    // Setup the fetch request  
    NSFetchRequest *request = [[NSFetchRequest alloc] init];  
    [request setEntity:entity];   
    
    // Define how we will sort the records  
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];  
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];  
    [request setSortDescriptors:sortDescriptors];  
    [sortDescriptor release];   
    
    // Fetch the records and handle an error  
    NSError *error;  
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];   
    
    if ( ! mutableFetchResults) {  
        // Handle the error.  
        // This is a serious error and should advise the user to restart the application  
    }   
    
    // Save our fetched data to an array  
    [self setEvents:mutableFetchResults];  
    [mutableFetchResults release];  
    [request release];  
}



#pragma makr - Misc

- (void)longCellPress:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UITableViewCell *cell = (UITableViewCell *)[recognizer view];
        self.currentCellIndexPath = [self.tableView indexPathForCell:cell];
        UIAlertView *message = [[[UIAlertView alloc] initWithTitle:@"Warning!"
                                                          message:@"Delete an event?"
                                                         delegate:self
                                                cancelButtonTitle:@"No"
                                                otherButtonTitles:@"Yes", nil] autorelease];
        [message show];
    }
}

- (void)addEvent:(id)sender
{
    EventTypeChooser *chooserView = [[EventTypeChooser alloc] init];
    chooserView.title = @"Event types";
    chooserView.navigationController = self.navigationController;
    chooserView.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:chooserView animated:YES];
    [chooserView release];
}

@end
