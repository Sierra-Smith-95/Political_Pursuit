//
//  Trivia.h
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriviaQuestion.h"
#import "Player.h"

int CategoryLoaded;
int QuestionSelected;

BOOL Answer1Correct;
BOOL Answer2Correct;
BOOL Answer3Correct;
BOOL Answer4Correct;



int ScoreNumber;

BOOL GameInProgress;


@interface Trivia : UIViewController
{
    IBOutlet UILabel *CategorySelected;
    IBOutlet UILabel *QuestionText;
    
    IBOutlet UIButton *Answer1;
    IBOutlet UIButton *Answer2;
    IBOutlet UIButton *Answer3;
    IBOutlet UIButton *Answer4;
        
    IBOutlet UILabel *Result;
    IBOutlet UILabel *Score;
    
    IBOutlet UIButton *NextQuestion;
    
    IBOutlet UIButton *Exit;
    
    NSMutableArray *dukeQuestions;
    int curIndex;
    
    
}

-(IBAction)Answer1:(id)sender;
-(IBAction)Answer2:(id)sender;
-(IBAction)Answer3:(id)sender;
-(IBAction)Answer4:(id)sender;

-(void)RightAnswer;
-(void)WrongAnswer;

-(IBAction)NextQuestion:(id)sender;
 
-(IBAction)Exit:(id)sender;

@property (nonatomic, strong) Player *curPlayer;
@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSString *catagory;

@end
