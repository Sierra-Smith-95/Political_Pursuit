//
//  CalenderTableViewController.h
//  Political Pursuit
//
//  Created by Eric Saba on 12/7/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "EventObject.h"
#import "Player.h"

@interface CalenderTableViewController : UITableViewController

@property (nonatomic, strong) Player *curPlayer;

@end
