//
//  Player.h
//  Political Pursuit
//
//  Created by Sierra Smith on 10/9/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic) int score;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *myID;
@property (nonatomic) int curQIndex;
@property (nonatomic) BOOL calAdmin;
@property (nonatomic) BOOL triviaAdmin;

-(NSDictionary *)toDict;
-(void) fromDict: (NSDictionary *) dict;
@end
