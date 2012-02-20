//
//  EventTypes.m
//  Event
//
//  Created by Dima Nezhivoj on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventTypes.h"

@interface EventTypes () {
    NSDictionary *_eventTypeIDs;
}
@end



@implementation EventTypes

static EventTypes *_instance;

static void singleton_remover() {
    [_instance release];
}

+ (EventTypes *)instance {
    @synchronized(self) {
        if( ! _instance) {
            [[self alloc] init];
        }
    }    
    return _instance;
}

- (id)init {
    self = [super init];
    _instance = self;
    atexit(singleton_remover);
    
    _eventTypeIDs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     [NSDictionary dictionaryWithObjectsAndKeys: @"Went to college", @"eventName", @"PlaceEvent", @"eventType", nil], [NSNumber numberWithInt:0],
                     [NSDictionary dictionaryWithObjectsAndKeys: @"Went home", @"eventName", @"PlaceEvent", @"eventType", nil], [NSNumber numberWithInt:1], 
                     [NSDictionary dictionaryWithObjectsAndKeys: @"Met with friends", @"eventName", @"FriendsEvent", @"eventType", nil], [NSNumber numberWithInt:2],
                     [NSDictionary dictionaryWithObjectsAndKeys: @"Cinema with friends", @"eventName", @"FriendsEvent", @"eventType", nil], [NSNumber numberWithInt:3],
                     [NSDictionary dictionaryWithObjectsAndKeys: @"Born", @"eventName", @"PersoneEvent", @"eventType", nil], [NSNumber numberWithInt:4],
                     [NSDictionary dictionaryWithObjectsAndKeys: @"Died", @"eventName", @"PersoneEvent", @"eventType", nil], [NSNumber numberWithInt:5], 
                     [NSDictionary dictionaryWithObjectsAndKeys: @"Drinked", @"eventName", @"DrinkedEvent", @"eventType", nil], [NSNumber numberWithInt:6], nil];
    NSLog(@"Events are created! - %@", _eventTypeIDs);
    
    return self;
}

- (void)dealloc
{
    [_eventTypeIDs release], _eventTypeIDs = nil;
    [super dealloc];
}



#pragma mark - Manipulation with types

- (NSArray *)allEventNames
{
    return [[_eventTypeIDs allValues] valueForKey:@"eventName"];
}

- (NSString *)eventNameForID:(NSNumber *)typeID
{
    return [[_eventTypeIDs objectForKey:typeID] valueForKey:@"eventName"];
}

- (NSNumber *)eventIDForEventName:(NSString *)name
{
    NSMutableDictionary *namesAndIDs = [[NSMutableDictionary alloc] init];
    for (NSNumber *eventID in [_eventTypeIDs allKeys]) {
        [namesAndIDs setValue:eventID forKey:[[_eventTypeIDs objectForKey:eventID] valueForKey:@"eventName"]]; 
    }
    
    [namesAndIDs autorelease];
    
    return [namesAndIDs valueForKey:name];
}

- (NSString *)eventTypeForID:(NSNumber *)typeID
{
    return [[_eventTypeIDs objectForKey:typeID] valueForKey:@"eventType"];
}

- (NSString *)eventTypeForEventName:(NSString *)name
{
    return [self eventTypeForID:[self eventIDForEventName:name]];
}

@end
