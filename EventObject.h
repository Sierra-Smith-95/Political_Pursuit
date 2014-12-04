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

@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *location;
@property (nonatomic, weak) NSDate *startDate;
@property (nonatomic, weak) NSString *details;
@property (nonatomic, weak) NSDate *endDate;

-(PFObject *)eventToPFObj;
-(id)initWithPFObj:(PFObject *)obj;
@end
