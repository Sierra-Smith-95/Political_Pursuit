//
//  AddEventViewController.m
//  Political Pursuit
//
//  Created by Sierra Smith on 11/16/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "AddEventViewController.h"
#define kDatePickerCellHeight 164

@interface AddEventViewController ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSIndexPath *datePickerIndexPath;
@property (assign) BOOL firstDatePickerIsShowing;
@property (assign) BOOL secondDatePickerIsShowing;
@property (weak, nonatomic) UIDatePicker *datePicker;


@property (weak, nonatomic) IBOutlet UITextField *TitleCell;
@property (weak, nonatomic) IBOutlet UITextField *LocationCell;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionCell;
@property (weak, nonatomic) IBOutlet UILabel *EventStartLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *StartDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *EndDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *EndDatePicker;
@property (strong, nonatomic) UITextField *activeTextField;

@end

@implementation AddEventViewController

- (BOOL)datePickerIsShown {
    
    return self.datePickerIndexPath != nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeTextField = textField;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3){
        
        if(self.secondDatePickerIsShowing == YES){
            self.datePicker = self.EndDatePicker;
            [self hideDatePickerCell];
        }
        
        if (self.firstDatePickerIsShowing){
            self.datePicker = self.StartDatePicker;
            [self hideDatePickerCell];
            
        }else {
            self.datePicker = self.StartDatePicker;
            [self.activeTextField resignFirstResponder];
            [self showDatePickerCell];
        }
    }
    
    else if(indexPath.row == 4 && self.firstDatePickerIsShowing == NO)
    {
        if (self.secondDatePickerIsShowing){
            self.datePicker = self.EndDatePicker;
            [self hideDatePickerCell];
            
        }else {
            self.datePicker = self.EndDatePicker;
            [self.activeTextField resignFirstResponder];
            [self showDatePickerCell];
        }
    }
    else if(indexPath.row == 5 && self.firstDatePickerIsShowing == YES){
        self.datePicker = self.StartDatePicker;
        [self hideDatePickerCell];
        self.datePicker = self.EndDatePicker;
        [self.activeTextField resignFirstResponder];
        [self showDatePickerCell];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [self signUpForKeyboardNotifications];
    self.firstDatePickerIsShowing = YES;
    self.secondDatePickerIsShowing = YES;
//    self.datePicker = self.StartDatePicker;
//    [self hideDatePickerCell];
//    self.datePicker = self.EndDatePicker;
//    [self hideDatePickerCell];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 47.0f;
    }
    else if (indexPath.row == 2) {
        return 162.0f;
    }
    else if (indexPath.row == 4 && self.firstDatePickerIsShowing){
        return 164.0f;
    }
    else if (indexPath.row == 4) {
        return tableView.rowHeight;
    }
    else if (indexPath.row == 5 && self.secondDatePickerIsShowing) {
        return 164.0f;
    }
    else {
        return tableView.rowHeight;
    }
    
}

- (void)keyboardWillShow {
    
    if (self.firstDatePickerIsShowing || self.secondDatePickerIsShowing){
        
        [self hideDatePickerCell];
    }
}

- (void)hideDatePickerCell {
    
    if (self.firstDatePickerIsShowing) {
        self.firstDatePickerIsShowing = NO;
    } else {
        self.secondDatePickerIsShowing = NO;
    }
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.datePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.datePicker.hidden = YES;
                     }];
}

- (void)showDatePickerCell {
    
    if(self.datePicker == self.StartDatePicker){
        self.firstDatePickerIsShowing = YES;
    }
    else{
        self.secondDatePickerIsShowing = YES;
    }
    
    [self.tableView beginUpdates];
    
    [self.tableView endUpdates];
    
    self.datePicker.hidden = NO;
    self.datePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.datePicker.alpha = 1.0f;
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    } else {
        
        return 4;
    }
}

- (void)signUpForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
