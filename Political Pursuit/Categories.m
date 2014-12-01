//
//  Categories.m
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "Categories.h"
#import "Trivia.h"

@interface Categories ()
@property (nonatomic) int selected;
@end

@implementation Categories

-(IBAction)Button1:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:Category1SelectedNumber forKey:@"CategorySaved"];
    self.selected = 1;
}

-(IBAction)Button2:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:Category2SelectedNumber forKey:@"CategorySaved"];
    self.selected = 0;
}

-(IBAction)Exit:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    Category1Number = 0;
    Category2Number = 1;
    
    switch (Category1Number) {
        case 0:
            [Category1 setTitle:@"Duke Politics" forState:UIControlStateNormal];
            Category1SelectedNumber = 1;
            break;
        default:
            break;
    }
    
    switch (Category2Number) {
        case 1:
            [Category2 setTitle:@"National Politics" forState:UIControlStateNormal];
            Category2SelectedNumber = 2;
            break;
        default:
            break;
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self.tabBarController.tabBar setHidden:NO];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Trivia *triviaVC = (Trivia *)segue.destinationViewController;
    triviaVC.curPlayer = self.curPlayer;
    if (self.selected == 1) triviaVC.catagory = @"Duke Politics";
    else triviaVC.catagory = @"National Politics";
}

@end
