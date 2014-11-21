//
//  SecondViewController.m
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "SecondViewController.h"
#import "Categories.h"
#import <Parse/Parse.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    
    PFQuery * query = [PFQuery queryWithClassName:@"User"];
    [query getObjectInBackgroundWithId:self.curPlayer.myID block:^(PFObject *object, NSError *error) {
        
        self.curPlayer.score = [object[@"score"] intValue];
    }];
    
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Categories *catvc = (Categories *)segue.destinationViewController;
    catvc.curPlayer = self.curPlayer;
}

@end
