//
//  SignUp.m
//  Political Pursuit
//
//  Created by Charles Copti on 10/3/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "SignUp.h"
#import "Player.h"
#import <Parse/Parse.h>
#import <CommonCrypto/CommonDigest.h>
#import "Profile.h"
#import "Trivia.h"
#import "CalendarViewController.h"
#import "SecondViewController.h"

@interface SignUp ()

@property (nonatomic, weak) IBOutlet UITextField *enterUsername;
@property (nonatomic, weak) IBOutlet UITextField *enterPassword;
@property (nonatomic, weak) IBOutlet UITextField *retypePassword;

@property (nonatomic, strong) Player *curPlayer;

@end

@implementation SignUp

-(IBAction)createAccount:(id)sender{
    //resign all responders
    [self.enterUsername resignFirstResponder];
    [self.enterPassword resignFirstResponder];
    [self.retypePassword resignFirstResponder];
    
    bool uniqueUser = true;
    bool makeAccount = true;
    
    for (NSString *key in [self.credentials allKeys]) {
        if ([key isEqualToString:_enterUsername.text]) {
            uniqueUser = false;
            break;
        }
    }
    
    if (!uniqueUser) {
        makeAccount = false;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username Taken" message:@"This username is already in use.  Please choose another." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
    //check passwords are the same
    if ([_enterPassword.text isEqualToString:_retypePassword.text]) {
        //then add to a dictionary
        newDictionary= [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects: _enterPassword.text, nil] forKeys:[NSArray arrayWithObjects: _enterUsername.text, nil]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account Created" message:@"You're account has been made. Welcome!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else {
        makeAccount = false;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Don't Match" message:@"The two entered passwords do not match" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (makeAccount) {
        Player *newUser = [[Player alloc] init];
        newUser.score = 0;
        newUser.username = _enterUsername.text;
        newUser.password = [self sha1:_enterPassword.text];
        
        //call the method in firstViewController to add new user
        [self.delegate addAccount:newUser];
        
        PFObject *player = [PFObject objectWithClassName:@"User"];
        player[@"score"] = @0;
        player[@"userName"] = newUser.username;
        player[@"password"] = newUser.password;
        player[@"calAdmin"] = @NO;
        player[@"triviaAdmin"] = @NO;
        [player saveInBackground];
        
        newUser.myID = player.objectId;
        
        self.curPlayer = newUser;
        
        [self performSegueWithIdentifier:@"MainPageSegue" sender:sender];
    }
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MainPageSegue"])  {
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
}


@end
