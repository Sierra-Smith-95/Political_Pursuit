//
//  Player.m
//  Political Pursuit
//
//  Created by Sierra Smith on 10/9/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "Player.h"

@implementation Player

-(NSDictionary *)toDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:self.score] forKey:@"score"];
    [dict setObject:self.username forKey:@"username"];
    [dict setObject:self.password forKey:@"password"];
//    [dict setObject:[NSNumber numberWithInt:self.myID] forKey:@"id"];
    [dict setObject:[NSNumber numberWithInt: self.curQIndex] forKey:@"qIndex"];
    
    NSDictionary *toReturn = [NSDictionary dictionaryWithDictionary:dict];
    return toReturn;
}

-(void) fromDict: (NSDictionary *) dict{
    self.score = [[dict objectForKey:@"score"] integerValue];
    self.username = [dict objectForKey:@"username"];
    self.password = [dict objectForKey:@"password"];
//    self.myID = [[dict objectForKey:@"id"] integerValue];
    self.curQIndex = [[dict objectForKey:@"qIndex"] integerValue];
}
@end
