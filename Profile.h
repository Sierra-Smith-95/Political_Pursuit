//
//  Profile.h
//  Political Pursuit
//
//  Created by Charles Copti on 10/3/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface Profile : UIViewController {
    IBOutlet UIButton *LogOut;
    
}

-(IBAction)LogOut:(id)sender;

@property (nonatomic, strong) Player *curPlayer;
@end
