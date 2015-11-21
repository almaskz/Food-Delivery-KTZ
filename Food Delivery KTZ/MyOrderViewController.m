//
//  MyOrderViewController.m
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import "MyOrderViewController.h"
#import <Parse/Parse.h>
#import "DataHolder.h"

@interface MyOrderViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *myOrderItems;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getDataFromParse];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getDataFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"OrderItem"];
    [query whereKey:@"order" equalTo:[DataHolder getOrder]];
    [query includeKey:@"food"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.myOrderItems = objects;
            [self.tableView reloadData];
            [self calculateCost]; 
        }
    }];
}


-(void) calculateCost {
    int total = 0;
    for (int i=0; i < self.myOrderItems.count; i++) {
        int cost = [self.myOrderItems[i][@"food"][@"price"] intValue];
        total += cost;
    }
    
    self.resultLabel.text = [NSString stringWithFormat:@"ИТОГО: %d", total];
}


- (IBAction)confirmButtonPressed:(id)sender {
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myOrderItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.myOrderItems[indexPath.row][@"food"][@"title"];
    cell.detailTextLabel.text = [self.myOrderItems[indexPath.row][@"food"][@"price"] stringValue];
    
    return cell;
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
