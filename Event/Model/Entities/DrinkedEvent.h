//
//  DrinkedEvent.h
//  Event
//
//  Created by Dima Nezhivoj on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PlaceEvent.h"


@interface DrinkedEvent : PlaceEvent

@property (nonatomic, retain) NSString * beverage;

@end
