//
//  CalendarDetailViewController.m
//  Political Pursuit
//
//  Created by Charles Copti on 11/9/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "CalendarDetailViewController.h"
#import <EventKit/EventKit.h>

@interface CalendarDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UITextView *decriptionTextView;

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self.navigationItem setTitle:self.curEvent.title];
    [self.locationLabel setText:self.curEvent.location];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [self.startLabel setText:[dateFormatter stringFromDate:self.curEvent.startDate]];
    [self.endLabel setText:[dateFormatter stringFromDate:self.curEvent.endDate]];
    [self.decriptionTextView setText:self.curEvent.details];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPressed:(id)sender {
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = self.curEvent.title;
        event.startDate = self.curEvent.startDate;
        event.endDate = self.curEvent.endDate;
        event.location = self.curEvent.location;
        [event setCalendar:[store defaultCalendarForNewEvents]];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
