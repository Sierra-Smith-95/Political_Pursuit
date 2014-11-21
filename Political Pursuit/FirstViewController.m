//
//  FirstViewController.m
//  Political Pursuit
//
//  Created by Charles Copti on 9/22/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "Player.h"
#import "FirstViewController.h"
#import <Parse/Parse.h>
#import <CommonCrypto/CommonDigest.h>
#import "Profile.h"
#import "Trivia.h"
#import "CalendarViewController.h"
#import "SecondViewController.h"


@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) Player *curPlayer;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    
    credentialsDictionary = [[NSMutableDictionary alloc] init];
    playerArray = [[NSMutableArray alloc] init];
    
    //this query pulls down every single user object from the server.
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            NSString *username = [object objectForKey:@"userName"];
            NSString *password = [object objectForKey:@"password"];
            [credentialsDictionary setObject:password forKey:username];
            
            Player *thisPlayer = [[Player alloc]init];
            thisPlayer.username = username;
            thisPlayer.password = password;
            thisPlayer.score = [[object objectForKey:@"score"] integerValue];
            thisPlayer.myID = object.objectId;
            
            [playerArray addObject:thisPlayer];
        }
        
    }];
}

-(void) viewDidAppear:(BOOL)animated{
    [self.userNameField setText:@""];
    [self.passwordField setText:@""];
}

-(void) addAccount:(Player *) user{
    
    //Add to player array as well as credentialsDict
    
    NSDictionary *Dict = user.toDict;
    [credentialsDictionary addEntriesFromDictionary:Dict];
}

-(IBAction)enterCredentials: (id) sender{
    NSString *password = [self sha1:_passwordField.text];
    if ( [[credentialsDictionary objectForKey: _userNameField.text] isEqualToString: password]) {
        for (Player *thisPlayer in playerArray) {
            if ([_userNameField.text isEqualToString:thisPlayer.username]) {
                self.curPlayer = thisPlayer;
            }
        }
        [self performSegueWithIdentifier:@"LogInSegue" sender:sender];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"This password is incorrect" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField{
    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"SignUpSegue"])  {
         SignUp *signUpController = segue.destinationViewController;
         signUpController.delegate = self;
         signUpController.credentials = credentialsDictionary;
     }
     if ([segue.identifier isEqualToString:@"LogInSegue"])  {
         UITabBarController *tabCont = segue.destinationViewController;
         for (UIViewController *vc in tabCont.childViewControllers) {
             if ([vc isKindOfClass:[Profile class]]) {
                 Profile *profileVC = (Profile *)vc;
                 profileVC.curPlayer = self.curPlayer;
             }
             else if ([vc isKindOfClass:[Trivia class]]) {
                 UINavigationController *navCont = (UINavigationController *)vc;
                 SecondViewController *secondVC = (SecondViewController *)[navCont parentViewController];
                 secondVC.curPlayer = self.curPlayer;
             }
             else if ([vc isKindOfClass:[CalendarViewController class]]) {
                 UINavigationController *navCont = (UINavigationController *)vc;
                 CalendarViewController *calenderVC = (CalendarViewController *)[navCont parentViewController];
                 calenderVC.curPlayer = self.curPlayer;
             }
         }
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 

@end

