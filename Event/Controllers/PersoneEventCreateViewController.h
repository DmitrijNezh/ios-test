//
//  PersoneCreateEventViewController.h
//  Event
//
//  Created by Dima Nezhivoj on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseEventCreateViewController.h"

@interface PersoneEventCreateViewController : BaseEventCreateViewController<UITextFieldDelegate>

@property (nonatomic, retain) UITextField *name;

@end
