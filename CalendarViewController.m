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
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (nonatomic, strong) NSMutableArray *events;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.events = [[NSMutableArray alloc] init];
    
//    if (self.curPlayer.calAdmin == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
//    }
//    else{
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//    }
    UITableViewController *tableController = [[UITableViewController alloc]init];
    tableController.view = self.tableview;
    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventAllEvents];
    tableController.refreshControl = self.refresh;
    
    [self loadData];
}

- (void)refreshTable {
    [self.refresh beginRefreshing];
    [self loadData];
    [self.refresh endRefreshing];
}

- (void)loadData {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
   CalendarViewController *__weak weakSelf = self;
    
    //doesn't work
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            EventObject *thisEvent = [[EventObject alloc] initWithPFObj:object];
            [array addObject:thisEvent];
        }
        CalendarViewController *strongSelf = weakSelf;
        strongSelf.events = array;
        [strongSelf.tableview reloadData];
    }];
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
    
    NSMutableArray *array = self.events;
    EventObject *event = [array objectAtIndex:indexPath.row];
    NSString *title = event.title;
    [cell.textLabel setText:title];
    [cell.detailTextLabel setText:event.location];
    
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
