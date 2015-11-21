//
//  ManagerOrderDetailsViewController.m
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import "ManagerOrderDetailsViewController.h"

@interface ManagerOrderDetailsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *orderItems;
@end

@implementation ManagerOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    
    [self getDataFromParse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"OrderItem"];
    [query whereKey:@"order" equalTo:self.order];
    [query includeKey:@"food"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.orderItems = objects;
            
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Общая информация";
    } else {
        return @"Заказ";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    } else {
        return self.orderItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Поезд";
            cell.detailTextLabel.text = self.order[@"train"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Станция";
            cell.detailTextLabel.text = self.order[@"station"];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Вагон";
            cell.detailTextLabel.text = self.order[@"wagon"];
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Имя";
            cell.detailTextLabel.text = self.order[@"name"];
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"Телефон";
            cell.detailTextLabel.text = self.order[@"phone"];
        } else if (indexPath.row == 5) {
            cell.textLabel.text = @"Е-майл";
            cell.detailTextLabel.text = self.order[@"email"];
        }
    } else {
        cell.textLabel.text = self.orderItems[indexPath.row][@"food"][@"title"];
        cell.detailTextLabel.text = [self.orderItems[indexPath.row][@"food"][@"price"] stringValue];
    }
    
    
    return  cell;
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
