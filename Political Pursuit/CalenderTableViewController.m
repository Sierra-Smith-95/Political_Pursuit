//
//  CalenderTableViewController.m
//  Political Pursuit
//
//  Created by Eric Saba on 12/7/14.
//  Copyright (c) 2014 Political Pursuit. All rights reserved.
//

#import "CalenderTableViewController.h"
#import "CalendarDetailViewController.h"

@interface CalenderTableViewController ()
@property (nonatomic, strong) NSMutableArray *events;
@end

@implementation CalenderTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.events = [[NSMutableArray alloc] init];
    
    if (self.curPlayer.calAdmin == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    else {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventAllEvents];
    
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
    [self loadData];
}

- (void)refreshTable {
    [self.refreshControl beginRefreshing];
    [self loadData];
    [self.refreshControl endRefreshing];
}

- (void)loadData {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            EventObject *event = [[EventObject alloc] initWithPFObj:object];
            
            
            [array addObject:event];
        }
        [self.tableView reloadData];
    }];
    
    self.events = array;
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
    
    NSString *title = event.title;
    [cell.textLabel setText:title];
    [cell.detailTextLabel setText:event.location];
    
    return cell;
}

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
