//
//  Categories.h
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

int Category1Number;
int Category2Number;

int Category1SelectedNumber;
int Category2SelectedNumber;


@interface Categories : UIViewController
{
    IBOutlet UIButton *Category1;
    IBOutlet UIButton *Category2;
    
    IBOutlet UIButton *Exit;
}

-(IBAction)Button1:(id)sender;
-(IBAction)Button2:(id)sender;

-(IBAction)Exit:(id)sender;

@property (nonatomic, strong) Player *curPlayer;

@end
