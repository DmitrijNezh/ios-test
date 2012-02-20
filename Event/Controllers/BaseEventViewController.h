//
//  BaseModalViewController.h
//  Event
//
//  Created by Dima Nezhivoj on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface BaseEventViewController : UITableViewController

@property (nonatomic, assign) Event *event;

- (void)drawInCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath;

@end
