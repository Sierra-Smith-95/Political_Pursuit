//
//  Trivia.m
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import <Parse/Parse.h>
#import "Trivia.h"

@interface Trivia ()

@end

@implementation Trivia

-(IBAction)NextQuestion:(id)sender{
}


-(void) RightAnswer{
    ScoreNumber = ScoreNumber + 5;
    
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
    Answer1.hidden = YES;
    Answer2.hidden = YES;
    Answer3.hidden = YES;
    Answer4.hidden = YES;
    QuestionText.hidden = YES;
    CategorySelected.hidden = YES;
    
    Result.hidden = NO;
    Result.text = [NSString stringWithFormat:@"Correct!"];
    
    NextQuestion.hidden = NO;
}

-(void) WrongAnswer{
    ScoreNumber = ScoreNumber;
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
    Answer1.hidden = YES;
    Answer2.hidden = YES;
    Answer3.hidden = YES;
    Answer4.hidden = YES;
    QuestionText.hidden = YES;
    CategorySelected.hidden = YES;
    
    Result.hidden = NO;
    Result.text = [NSString stringWithFormat:@"Wrong!"];
    
    NextQuestion.hidden = NO;
}

-(IBAction)Answer1:(id)sender{
    if (Answer1Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
}

-(IBAction)Answer2:(id)sender{
    if (Answer2Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
}

-(IBAction)Answer3:(id)sender{
    if (Answer3Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
}

-(IBAction)Answer4:(id)sender{
    if (Answer4Correct == YES) {
        [self RightAnswer];
    }
    else{
        [self WrongAnswer];
    }
}


-(IBAction)Exit:(id)sender{

    PFQuery * query = [PFQuery queryWithClassName:@"User"];
    [query getObjectInBackgroundWithId:self.curPlayer.myID block:^(PFObject *object, NSError *error) {
        object[@"score"] = [NSNumber numberWithInt:ScoreNumber];
        [object saveInBackground];
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)Category1{
    
    /*
    
    //load in the correct trivia questions to the array and set the index in the array based on player index?
    
    
    
    curIndex = 0;
    
    //set up screen based on current question
    
    TriviaQuestion *curQuestion = dukeQuestions[curIndex];
    
    QuestionText.text = curQuestion.question;
    [Answer1 setTitle: curQuestion.option1 forState:UIControlStateNormal];
    [Answer2 setTitle: curQuestion.option2 forState:UIControlStateNormal];
    [Answer3 setTitle: curQuestion.option3 forState:UIControlStateNormal];
    [Answer4 setTitle: curQuestion.option4 forState:UIControlStateNormal];
    
    int correctResponse = curQuestion.correctAns;
    
    if (correctResponse == 1) {
        Answer1Correct = YES;
    }
    if (correctResponse == 2) {
        Answer2Correct = YES;
    }
    if (correctResponse == 3) {
        Answer3Correct = YES;
    }
    if (correctResponse == 4) {
        Answer4Correct = YES;
    }
    
    */
     
    switch (QuestionSelected) {
        case 0:
            QuestionText.text = [NSString stringWithFormat:@"Who is the best Superhero?"];
            [Answer1 setTitle: @"Batman" forState:UIControlStateNormal];
            [Answer2 setTitle: @"Aquaman" forState:UIControlStateNormal];
            [Answer3 setTitle: @"Superman" forState:UIControlStateNormal];
            [Answer4 setTitle: @"Green Arrow" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 1:
            QuestionText.text = [NSString stringWithFormat:@"Who you gonna call?"];
            [Answer1 setTitle: @"The President" forState:UIControlStateNormal];
            [Answer2 setTitle: @"Mr. Rogers" forState:UIControlStateNormal];
            [Answer3 setTitle: @"Ghostbusters!" forState:UIControlStateNormal];
            [Answer4 setTitle: @"Tommy Sowers" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 2:
            QuestionText.text = [NSString stringWithFormat:@"The Little Mermaid was released in..."];
            [Answer1 setTitle: @"2012" forState:UIControlStateNormal];
            [Answer2 setTitle: @"1989" forState:UIControlStateNormal];
            [Answer3 setTitle: @"1990!" forState:UIControlStateNormal];
            [Answer4 setTitle: @"1993" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 3:
            QuestionText.text = [NSString stringWithFormat:@"Duke University is..."];
            [Answer1 setTitle: @"Amazing" forState:UIControlStateNormal];
            [Answer2 setTitle: @"not as good as UNC" forState:UIControlStateNormal];
            [Answer3 setTitle: @"a crappy basketball team" forState:UIControlStateNormal];
            [Answer4 setTitle: @"an elementary school?" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
            
        default:
            break;
    }
}

-(void)Category2{
    switch (QuestionSelected) {
        case 0:
            QuestionText.text = [NSString stringWithFormat:@"Who is the best Superhero?"];
            [Answer1 setTitle: @"Batman" forState:UIControlStateNormal];
            [Answer2 setTitle: @"Aquaman" forState:UIControlStateNormal];
            [Answer3 setTitle: @"Superman" forState:UIControlStateNormal];
            [Answer4 setTitle: @"Green Arrow" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 1:
            QuestionText.text = [NSString stringWithFormat:@"Who you gonna call?"];
            [Answer1 setTitle: @"The President" forState:UIControlStateNormal];
            [Answer2 setTitle: @"Mr. Rogers" forState:UIControlStateNormal];
            [Answer3 setTitle: @"Ghostbusters!" forState:UIControlStateNormal];
            [Answer4 setTitle: @"Tommy Sowers" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 2:
            QuestionText.text = [NSString stringWithFormat:@"The Little Mermaid was released in..."];
            [Answer1 setTitle: @"2012" forState:UIControlStateNormal];
            [Answer2 setTitle: @"1989" forState:UIControlStateNormal];
            [Answer3 setTitle: @"1990!" forState:UIControlStateNormal];
            [Answer4 setTitle: @"1993" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 3:
            QuestionText.text = [NSString stringWithFormat:@"Duke University is..."];
            [Answer1 setTitle: @"Amazing" forState:UIControlStateNormal];
            [Answer2 setTitle: @"not as good as UNC" forState:UIControlStateNormal];
            [Answer3 setTitle: @"a crappy basketball team" forState:UIControlStateNormal];
            [Answer4 setTitle: @"an elementary school?" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    
    [self.tabBarController.tabBar setHidden:YES];
    
    if (GameInProgress == NO) {
        ScoreNumber = 0;
        GameInProgress = YES;
    }
    
    Result.hidden = YES;
    NextQuestion.hidden = YES;
    
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
    
    Answer1Correct = NO;
    Answer2Correct = NO;
    Answer3Correct = NO;
    Answer4Correct = NO;
    
    
    CategoryLoaded = [[NSUserDefaults standardUserDefaults] integerForKey:@"CategorySaved"];
    
    QuestionSelected = arc4random() %4;
    
    switch (CategoryLoaded){
        case 1:
            CategorySelected.text = [NSString stringWithFormat:@"Duke Politics"];
            [self Category1];
            break;
        case 2:
            CategorySelected.text = [NSString stringWithFormat:@"National Politics"];
            [self Category2];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
