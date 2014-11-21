//
//  CalendarViewController.m
//  Political Pursuit
//
//  Created by Charles Copti on 11/4/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarDetailViewController.h"

@interface CalendarViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableview;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (self.curPlayer.calAdmin == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
//    }
//    else{
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //create events
    
    EventObject *event1 = [[EventObject alloc]init];
    event1.title = @"Political Debate";
    event1.location = @"Sanford";
    NSDate *newDate = [NSDate dateWithTimeInterval:20000.0 sinceDate:[NSDate date]];
    event1.date = newDate;
    event1.duration = 10;
    
    EventObject *event2 = [[EventObject alloc]init];
    event2.title = @"Republican Debate";
    event2.location = @"Sanford";
    event2.date = [NSDate date];
    event2.duration = 10;
    
    EventObject *event3 = [[EventObject alloc]init];
    event3.title = @"Democrat Debate";
    event3.location = @"Sanford";
    event3.date = [NSDate date];
    event3.duration = 10;
    
    [array addObject:event1];
    [array addObject:event2];
    [array addObject:event3];
    
    self.events = [array copy];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.events.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    EventObject *event = [self.events objectAtIndex:indexPath.row];
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = event.location;
    //this could also be date/time
    
    return cell;
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        UITableViewCell *thisCell = (UITableViewCell *)sender;
        NSString *eventTitle = thisCell.textLabel.text;
        EventObject *curEvent = [[EventObject alloc] init];
        for (EventObject *thisEvent in self.events) {
            if ([thisEvent.title isEqualToString:eventTitle]) {
                curEvent = thisEvent;
            }
        }
        
        CalendarDetailViewController *cdvc = (CalendarDetailViewController *)[segue destinationViewController];
        cdvc.curEvent = curEvent;
    }
}


@end
