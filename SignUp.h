//
//  SignUp.h
//  Political Pursuit
//
//  Created by Charles Copti on 10/3/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@protocol firstViewDelegate <NSObject>

-(void) addAccount:(Player *)user;


@end

@interface SignUp : UIViewController {
    
    IBOutlet UIButton *createAccount;
    NSMutableDictionary *newDictionary;
    

}

-(IBAction)createAccount:(id)sender;

@property (nonatomic, strong) id <firstViewDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *credentials;

@end
