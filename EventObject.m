//
//  EventObject.m
//  Political Pursuit
//
//  Created by Sierra Smith on 11/4/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "EventObject.h"

@implementation EventObject

-(PFObject *)eventToPFObj {
    PFObject *obj = [PFObject objectWithClassName:@"Event"];
    obj[@"title"] = self.title;
    obj[@"location"] = self.location;
    obj[@"description"] = self.details;
    obj[@"startDate"] = self.startDate;
    obj[@"endDate"] = self.endDate;
    
    return obj;
}

-(id)initWithPFObj:(PFObject *)obj {
    self = [super init];
    if (self) {
        self.title = [obj objectForKey:@"title"];
        self.location = [obj objectForKey:@"location"];
        self.details = [obj objectForKey:@"description"];
        self.startDate = [obj objectForKey:@"startDate"];
        self.endDate = [obj objectForKey:@"endDate"];
    }
    return self;
}

@end
