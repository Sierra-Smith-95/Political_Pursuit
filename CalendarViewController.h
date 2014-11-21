//
//  CalendarViewController.h
//  Political Pursuit
//
//  Created by Charles Copti on 11/4/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "EventObject.h"
#import "Player.h"

@interface CalendarViewController : UIViewController

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) Player *curPlayer;

@end
