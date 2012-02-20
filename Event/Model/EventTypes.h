//
//  EventTypes.h
//  Event
//
//  Created by Dima Nezhivoj on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventTypes : NSObject

// Get singleton instance
+ (EventTypes *)instance;

// Manipulation with types
- (NSArray *)allEventNames;
- (NSString *)eventNameForID:(NSNumber *)typeID;
- (NSNumber *)eventIDForEventName:(NSString *)name;
- (NSString *)eventTypeForID:(NSNumber *)typeID;
- (NSString *)eventTypeForEventName:(NSString *)name;

@end
