//
//  Trivia.m
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//yo

#import <Parse/Parse.h>
#import "Trivia.h"
#import "TriviaQuestion.h"

@interface Trivia ()

@end

@implementation Trivia

-(IBAction)NextQuestion:(id)sender{
    
    Result.hidden = YES;
    NextQuestion.hidden = YES;
    
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
    Answer1Correct = NO;
    Answer2Correct = NO;
    Answer3Correct = NO;
    Answer4Correct = NO;
    
    QuestionSelected = arc4random() %self.questions.count;
    
    [self loadQuestion];
    
    Answer1.hidden = NO;
    Answer2.hidden = NO;
    Answer3.hidden = NO;
    Answer4.hidden = NO;
    QuestionText.hidden = NO;
    CategorySelected.hidden = NO;
}

-(void) loadQuestion {
    TriviaQuestion *curQ = [self.questions objectAtIndex:QuestionSelected];
    QuestionText.text = curQ.question;
    [Answer1 setTitle:curQ.option1 forState:UIControlStateNormal];
    [Answer2 setTitle:curQ.option2 forState:UIControlStateNormal];
    [Answer3 setTitle:curQ.option3 forState:UIControlStateNormal];
    [Answer4 setTitle:curQ.option4 forState:UIControlStateNormal];

    if (curQ.correctAns == 1) Answer1Correct = YES;
    else if (curQ.correctAns == 2) Answer2Correct = YES;
    else if (curQ.correctAns == 3) Answer3Correct = YES;
    else Answer4Correct = YES;
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

- (void)viewDidLoad {
    
    [self.tabBarController.tabBar setHidden:YES];
    
    [CategorySelected setText:self.catagory];
    
    TriviaQuestion *one = [[TriviaQuestion alloc] init];
    one.question = @"Duke University is...";
    one.option1 = @"Amazing";
    one.option2 = @"not as good as UNC";
    one.option3 = @"a crappy basketball team";
    one.option4 = @"an elementary school?";
    one.correctAns = 1;
    
    TriviaQuestion *two = [[TriviaQuestion alloc] init];
    two.question = @"The Little Mermaid was released in...";
    two.option1 = @"2012";
    two.option2 = @"1989";
    two.option3 = @"1990!";
    two.option4 = @"1993";
    two.correctAns = 2;
    
    NSArray *theseQuestions = [[NSArray alloc] initWithObjects:one, two, nil];
    self.questions = theseQuestions;
    
    if (GameInProgress == NO) {
        ScoreNumber = self.curPlayer.score;
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
    
    QuestionSelected = arc4random() %self.questions.count;

    [self loadQuestion];
    
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
     
 }
*/

@end
