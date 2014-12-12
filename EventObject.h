//
//  EventObject.h
//  Political Pursuit
//
//  Created by Sierra Smith on 11/4/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface EventObject : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSDate *endDate;

-(PFObject *)eventToPFObj;
-(id)initWithPFObj:(PFObject *)obj;
@end
