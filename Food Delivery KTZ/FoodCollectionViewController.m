//
//  FoodCollectionViewController.m
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import "FoodCollectionViewController.h"
#import "FoodCollectionViewCell.h"
#import <Parse/Parse.h>
#import "DataHolder.h"


@interface FoodCollectionViewController ()

@property (strong, nonatomic) NSArray *foodsArray;

@end

@implementation FoodCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //    [self.collectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self getDataFromParse];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.foodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //NSLog(@"indexPath: %@", indexPath);
    
    PFFile *file = self.foodsArray[indexPath.row][@"image"];
    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            cell.myImageView.image = [UIImage imageWithData:data];
        }
    }];
    
    cell.nameTextField.text = self.foodsArray[indexPath.row][@"title"];
    //NSLog(@"title: %@", self.foodsArray[indexPath.row][@"title"]);
    cell.priceTextField.text = [self.foodsArray[indexPath.row][@"price"] stringValue];
    //NSLog(@"price: %@", self.foodsArray[indexPath.row][@"price"]);
    
    [cell setDidTapButtonBlock:^(id sender) {
        //NSLog(@"hello I am here in food collection view ");
        PFObject *order = [PFObject objectWithClassName:@"OrderItem"];
        order[@"food"] = self.foodsArray[indexPath.row];
        order[@"order"] = [DataHolder getOrder];
        [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (!error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ваш заказ принят" message:@"Вы можете просмотреть ваши заказы в меню \"Мои заказы\"" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ваш заказ принят" message:@"Вы можете просмотреть ваши заказы в меню \"Мои заказы\"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
            }
        }];
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void) getDataFromParse {
    PFQuery *query = [[PFQuery alloc] initWithClassName:@"Food"];
    [query whereKey:@"category" equalTo:self.category];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.foodsArray = objects;
            //NSLog(@"count: %lu", (unsigned long)self.foodsArray.count);
            [self.collectionView reloadData];
        }
    }];
}

@end
