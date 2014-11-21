//
//  TriviaQuestion.h
//  Political Pursuit
//
//  Created by Sierra Smith on 11/2/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TriviaQuestion : NSObject
@property (nonatomic, strong) NSString* question;
@property (nonatomic, strong) NSString* option1;
@property (nonatomic, strong) NSString* option2;
@property (nonatomic, strong) NSString* option3;
@property (nonatomic, strong) NSString* option4;
@property (nonatomic) int correctAns;

-(void) fromDict: (NSDictionary *) dict;

@end
