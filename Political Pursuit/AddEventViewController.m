//
//  AddEventViewController.m
//  Political Pursuit
//
//  Created by Sierra Smith on 11/16/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "AddEventViewController.h"
#import "EventObject.h"
#define kDatePickerCellHeight 164

@interface AddEventViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSIndexPath *datePickerIndexPath;
@property (weak, nonatomic) UIDatePicker *datePicker;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *eventStartLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

@end

@implementation AddEventViewController

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleTextField setText:@"Event Title"];
    [self.titleTextField setTextColor:[UIColor lightGrayColor]];
    [self.locationTextField setTextColor:[UIColor lightGrayColor]];
    [self.locationTextField setText:@"Event Location"];
    [self.descriptionTextView setTextColor:[UIColor lightGrayColor]];
    [self.descriptionTextView setText:@"Event Description"];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *startDate = [NSDate date];
    startDate = [self dateRoundedUpTo15Minutes:startDate];
    [self.startDatePicker setDate:startDate animated:YES];
    
    NSDate *endDate = [NSDate date];
    endDate = [self dateRoundedUpTo75Minutes:endDate];
    [self.endDatePicker setDate:endDate animated:YES];
    
    
    [self.eventStartLabel setText:[self.dateFormatter stringFromDate:[self.startDatePicker date]]];
    [self.endDateLabel setText:[self.dateFormatter stringFromDate:[self.endDatePicker date]]];
}

- (NSDate *) dateRoundedUpTo15Minutes:(NSDate *)dt{
    int referenceTimeInterval = (int)[dt timeIntervalSinceReferenceDate];
    int remainingSeconds = referenceTimeInterval % 900;
    int timeRoundedTo15Minutes = referenceTimeInterval - remainingSeconds;
    if(remainingSeconds>=60)
    {/// round up
        timeRoundedTo15Minutes = referenceTimeInterval +(900-remainingSeconds);
    }
    NSDate *roundedDate = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeRoundedTo15Minutes];
    return roundedDate;
}

- (NSDate *) dateRoundedUpTo75Minutes:(NSDate *)dt{
    int referenceTimeInterval = (int)[dt timeIntervalSinceReferenceDate];
    int remainingSeconds = referenceTimeInterval % 900;
    int timeRoundedTo15Minutes = referenceTimeInterval - remainingSeconds;
    if(remainingSeconds>=60)
    {/// round up
        timeRoundedTo15Minutes = referenceTimeInterval +(900-remainingSeconds);
    }
    timeRoundedTo15Minutes += 3600;
    NSDate *roundedDate = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeRoundedTo15Minutes];
    return roundedDate;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startValueChanged:(id)sender {
    [self.eventStartLabel setText:[self.dateFormatter stringFromDate:[self.startDatePicker date]]];
}

- (IBAction)endValueChanged:(id)sender {
    [self.endDateLabel setText:[self.dateFormatter stringFromDate:[self.endDatePicker date]]];
}

#pragma mark - UITextView and Field Events

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@"Event Location"] || [textField.text isEqualToString:@"Event Title"]) {
        [textField setText:@""];
        [textField setTextColor:[UIColor blackColor]];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        if ([textField isEqual:self.titleTextField]) {
            [textField setText:@"Event Title"];
        } else {
            [textField setText:@"Event Location"];
        }
        [textField setTextColor:[UIColor lightGrayColor]];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Event Description"]) {
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        [textView setTextColor:[UIColor lightGrayColor]];
        [textView setText:@"Event Description"];
    }
}

#pragma mark - UINavItem Events

- (IBAction)addPressed:(id)sender {
    [self.titleTextField resignFirstResponder];
    [self.locationTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    [self.endDatePicker resignFirstResponder];
    [self.startDatePicker resignFirstResponder];
    
    //Here we can check to make sure they filled out all of the fields and throw UIAlerts at the user.
    
    EventObject *newEvent = [[EventObject alloc] init];
    newEvent.title = self.titleTextField.text;
    newEvent.location = self.locationTextField.text;
    newEvent.details = self.descriptionTextView.text;
    newEvent.startDate = self.startDatePicker.date;
    newEvent.endDate = self.endDatePicker.date;
    
    PFObject *object = [newEvent eventToPFObj];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:^{}];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Save Event" message:@"We could not save your event. Check your network connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
}

- (IBAction)cancelPressed:(id)sender {
    [self.titleTextField resignFirstResponder];
    [self.locationTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    [self.endDatePicker resignFirstResponder];
    [self.startDatePicker resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
