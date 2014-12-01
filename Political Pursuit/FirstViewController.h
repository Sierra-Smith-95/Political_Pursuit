//
//  FirstViewController.h
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//  Charles has joined using GitHub.
//

#import <UIKit/UIKit.h>
#include "SignUp.h"

@protocol firstViewDelegate;
@class FirstViewController;


@interface FirstViewController : UIViewController <firstViewDelegate> {
    
    NSMutableDictionary *credentialsDictionary;
    NSMutableArray *playerArray;
    
}

-(IBAction)enterCredentials: (id) sender;


@end


