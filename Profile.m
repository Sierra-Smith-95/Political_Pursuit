//
//  Profile.m
//  Political Pursuit
//
//  Created by Charles Copti on 10/3/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "Profile.h"
#import <Parse/Parse.h>

@interface Profile ()
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@end

@implementation Profile

-(IBAction)LogOut:(id)sender{
    [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationItem setTitle:self.curPlayer.username];
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", self.curPlayer.score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    
    PFQuery * query = [PFQuery queryWithClassName:@"User"];
    [query getObjectInBackgroundWithId:self.curPlayer.myID block:^(PFObject *object, NSError *error) {
        
        self.curPlayer.score = [object[@"score"] intValue];
        self.pointsLabel.text = [NSString stringWithFormat:@"%d", self.curPlayer.score];
    }];
    
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
