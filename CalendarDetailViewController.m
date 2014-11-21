//
//  CalendarDetailViewController.m
//  Political Pursuit
//
//  Created by Charles Copti on 11/9/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "CalendarDetailViewController.h"

@interface CalendarDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventTitleLabel.text = self.curEvent.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(UIButton *)sender {
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
