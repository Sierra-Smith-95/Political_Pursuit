//
//  EventObject.h
//  Political Pursuit
//
//  Created by Sierra Smith on 11/4/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventObject : NSObject

@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *location;
@property (nonatomic, weak) NSDate *date;
@property (nonatomic, weak) NSString *details;
@property (nonatomic) int duration;

@end
